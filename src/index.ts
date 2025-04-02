import "@dotenvx/dotenvx/config";
import { SeverityNumber } from "@opentelemetry/api-logs";
import { OTLPLogExporter } from "@opentelemetry/exporter-logs-otlp-http";
import {
  AggregationTemporalityPreference,
  OTLPMetricExporter,
} from "@opentelemetry/exporter-metrics-otlp-http";
import { containerDetector } from "@opentelemetry/resource-detector-container";
import { detectResources } from "@opentelemetry/resources";
import {
  BatchLogRecordProcessor,
  LoggerProvider,
} from "@opentelemetry/sdk-logs";
import {
  MeterProvider,
  PeriodicExportingMetricReader,
} from "@opentelemetry/sdk-metrics";

// validate environment variables before starting the application
const requiredEnvVars = [
  "ORG_NAME",
  "PROJECT_NAME",
  "APPLICATION_NAME",
  "OTEL_EXPORTER_OTLP_LOGS_ENDPOINT",
  "OTEL_EXPORTER_OTLP_METRICS_ENDPOINT",
  "OTEL_EXPORTER_OTLP_METRICS_TEMPORALITY_PREFERENCE",
  "DD_API_KEY",
  "SNYK_TOKEN",
];

const missingEnvVars = requiredEnvVars.filter((envVar) => !process.env[envVar]);
if (missingEnvVars.length > 0) {
  console.error(
    `Missing required environment variables: ${missingEnvVars.join(", ")}`,
  );
  process.exit(1);
}

// otel: logs
const logExporter = new OTLPLogExporter({
  url: process.env.OTEL_EXPORTER_OTLP_LOGS_ENDPOINT, // url is optional and can be omitted - default is http://localhost:4318/v1/logs
  concurrencyLimit: 1, // an optional limit on pending requests
  headers: {
    "dd-protocol": "otlp",
    "dd-api-key": process.env.DD_API_KEY,
  },
});
const loggerProvider = new LoggerProvider();
const logProcessor = new BatchLogRecordProcessor(logExporter);
loggerProvider.addLogRecordProcessor(logProcessor);
const logger = loggerProvider.getLogger("default", "1.0.0");

// otel: metrics
const metricExporter = new OTLPMetricExporter({
  url: process.env.OTEL_EXPORTER_OTLP_METRICS_ENDPOINT, // url is optional and can be omitted - default is http://localhost:4318/v1/logs
  concurrencyLimit: 1, // an optional limit on pending requests
  headers: {
    "dd-protocol": "otlp",
    "dd-api-key": process.env.DD_API_KEY,
  },
  temporalityPreference: AggregationTemporalityPreference.DELTA,
});

const meterProvider = new MeterProvider({
  readers: [
    new PeriodicExportingMetricReader({
      exporter: metricExporter,
      exportIntervalMillis: 400,
    }),
  ],
});

const meter = meterProvider.getMeter("task-meter");

// Counters
const runCounter = meter.createCounter("task_run_count");
const successCounter = meter.createCounter("task_success_count");
const failureCounter = meter.createCounter("task_failure_count");
const errorTypeCounter = meter.createCounter("task_error_type_count");
const durationHistogram = meter.createHistogram("task_duration_ms");

process.on("uncaughtException", (error) => {
  console.error("Uncaught Exception:", error);
  logger.emit({
    severityNumber: SeverityNumber.ERROR,
    severityText: "ERROR",
    body: `Uncaught Exception: ${error.message}`,
    attributes: { "log.type": "custom" },
  });
});

process.on("unhandledRejection", (reason, promise) => {
  console.error("Unhandled Rejection at:", promise, "reason:", reason);
  logger.emit({
    severityNumber: SeverityNumber.ERROR,
    severityText: "ERROR",
    body: "Unhandled Rejection: " + reason,
    attributes: { "log.type": "custom" },
  });
});

process.on("warning", (warning) => {
  console.warn("Warning:", warning);
  logger.emit({
    severityNumber: SeverityNumber.WARN,
    severityText: "WARN",
    body: "Warning: " + warning.message,
    attributes: { "log.type": "custom" },
  });
});

process.on("exit", (code) => {
  console.log("Process exit with code:", code);
  logger.emit({
    severityNumber: SeverityNumber.INFO,
    severityText: "INFO",
    body: "Process exit with code: " + code,
    attributes: { "log.type": "custom" },
  });
});

process.on("SIGINT", () => {
  console.log("⛈️ Received SIGINT. Exiting...");
  logger.emit({
    severityNumber: SeverityNumber.INFO,
    severityText: "INFO",
    body: "Received SIGINT. Exiting...",
    attributes: { "log.type": "custom" },
  });
  process.exit(0);
});

logger.emit({
  severityNumber: SeverityNumber.INFO,
  severityText: "INFO",
  body: "Service started",
  attributes: {
    "service.name": process.env.APPLICATION_NAME,
    "service.id": "xyz",
  },
});

export const main = async () => {
  const start = Date.now();
  runCounter.add(1);

  const resource = await detectResources({
    detectors: [containerDetector],
  });

  try {
    console.log(`🍔 ${process.env.APPLICATION_NAME} is running...`);
    //
    // do work here
    //
    successCounter.add(1);
    const duration = Date.now() - start;
    logger.emit({
      severityNumber: SeverityNumber.INFO,
      severityText: "INFO",
      body: "Task succeeded",
      attributes: {
        "service.name": process.env.APPLICATION_NAME,
        "service.id": "xyz",
        "task.duration_ms": duration,
        "task.result": "success",
      },
    });
  } catch (err) {
    const durationUntilErr = Date.now() - start;
    failureCounter.add(1);
    errorTypeCounter.add(1, { error_type: err.name || "UnknownError" });
    logger.emit({
      severityNumber: SeverityNumber.ERROR,
      severityText: "ERROR",
      body: "Task failed",
      attributes: {
        "service.name": process.env.APPLICATION_NAME,
        "service.id": "xyz",
        "task.result": "failure",
        "task.duration_ms": durationUntilErr,
        "error.type": err.name,
        "error.message": err.message,
        "error.stack": err.stack,
      },
    });
    console.log(`❌ ${process.env.APPLICATION_NAME} failed: ${err.message}`);
  } finally {
    const duration = Date.now() - start;
    durationHistogram.record(duration);
  }
};

// Call the main function
main()
  .then(() => {
    console.log("🍔 Done");
  })
  .catch((error) => {
    console.error("Error:", error);
  });
