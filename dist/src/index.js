"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.main = void 0;
require("@dotenvx/dotenvx/config");
const api_logs_1 = require("@opentelemetry/api-logs");
const exporter_logs_otlp_http_1 = require("@opentelemetry/exporter-logs-otlp-http");
const exporter_metrics_otlp_http_1 = require("@opentelemetry/exporter-metrics-otlp-http");
const resource_detector_container_1 = require("@opentelemetry/resource-detector-container");
const resources_1 = require("@opentelemetry/resources");
const sdk_logs_1 = require("@opentelemetry/sdk-logs");
const sdk_metrics_1 = require("@opentelemetry/sdk-metrics");
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
const logExporter = new exporter_logs_otlp_http_1.OTLPLogExporter({
  url: process.env.OTEL_EXPORTER_OTLP_LOGS_ENDPOINT, // url is optional and can be omitted - default is http://localhost:4318/v1/logs
  concurrencyLimit: 1, // an optional limit on pending requests
  headers: {
    "dd-protocol": "otlp",
    "dd-api-key": process.env.DD_API_KEY,
  },
});
const loggerProvider = new sdk_logs_1.LoggerProvider();
const logProcessor = new sdk_logs_1.BatchLogRecordProcessor(logExporter);
loggerProvider.addLogRecordProcessor(logProcessor);
const logger = loggerProvider.getLogger("default", "1.0.0");
// otel: metrics
const metricExporter = new exporter_metrics_otlp_http_1.OTLPMetricExporter({
  url: process.env.OTEL_EXPORTER_OTLP_METRICS_ENDPOINT, // url is optional and can be omitted - default is http://localhost:4318/v1/logs
  concurrencyLimit: 1, // an optional limit on pending requests
  headers: {
    "dd-protocol": "otlp",
    "dd-api-key": process.env.DD_API_KEY,
  },
  temporalityPreference:
    exporter_metrics_otlp_http_1.AggregationTemporalityPreference.DELTA,
});
const meterProvider = new sdk_metrics_1.MeterProvider({
  readers: [
    new sdk_metrics_1.PeriodicExportingMetricReader({
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
    severityNumber: api_logs_1.SeverityNumber.ERROR,
    severityText: "ERROR",
    body: `Uncaught Exception: ${error.message}`,
    attributes: { "log.type": "custom" },
  });
});
process.on("unhandledRejection", (reason, promise) => {
  console.error("Unhandled Rejection at:", promise, "reason:", reason);
  logger.emit({
    severityNumber: api_logs_1.SeverityNumber.ERROR,
    severityText: "ERROR",
    body: "Unhandled Rejection: " + reason,
    attributes: { "log.type": "custom" },
  });
});
process.on("warning", (warning) => {
  console.warn("Warning:", warning);
  logger.emit({
    severityNumber: api_logs_1.SeverityNumber.WARN,
    severityText: "WARN",
    body: "Warning: " + warning.message,
    attributes: { "log.type": "custom" },
  });
});
process.on("exit", (code) => {
  console.log("Process exit with code:", code);
  logger.emit({
    severityNumber: api_logs_1.SeverityNumber.INFO,
    severityText: "INFO",
    body: "Process exit with code: " + code,
    attributes: { "log.type": "custom" },
  });
});
process.on("SIGINT", () => {
  console.log("⛈️ Received SIGINT. Exiting...");
  logger.emit({
    severityNumber: api_logs_1.SeverityNumber.INFO,
    severityText: "INFO",
    body: "Received SIGINT. Exiting...",
    attributes: { "log.type": "custom" },
  });
  process.exit(0);
});
logger.emit({
  severityNumber: api_logs_1.SeverityNumber.INFO,
  severityText: "INFO",
  body: "Service started",
  attributes: {
    "service.name": process.env.APPLICATION_NAME,
    "service.id": "xyz",
  },
});
const main = async () => {
  const start = Date.now();
  runCounter.add(1);
  const resource = await (0, resources_1.detectResources)({
    detectors: [resource_detector_container_1.containerDetector],
  });
  try {
    console.log(`🍔 ${process.env.APPLICATION_NAME} is running...`);
    //
    // do work here
    //
    successCounter.add(1);
    const duration = Date.now() - start;
    logger.emit({
      severityNumber: api_logs_1.SeverityNumber.INFO,
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
      severityNumber: api_logs_1.SeverityNumber.ERROR,
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
exports.main = main;
// Call the main function
(0, exports.main)()
  .then(() => {
    console.log("🍔 Done");
  })
  .catch((error) => {
    console.error("Error:", error);
  });
//# sourceMappingURL=index.js.map
