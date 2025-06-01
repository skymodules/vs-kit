"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.main = void 0;
const main = async () => {
    try {
        console.log(`🍔 ${process.env.APPLICATION_NAME} is running...`);
    }
    catch (err) {
        console.log(`❌ ${process.env.APPLICATION_NAME} failed: ${err.message}`);
    }
    finally {
        console.log(`🍔 ${process.env.APPLICATION_NAME} has finished.`);
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