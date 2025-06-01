
export const main = async () => {

  try {
    console.log(`🍔 ${process.env.APPLICATION_NAME} is running...`);
  } catch (err) {
    console.log(`❌ ${process.env.APPLICATION_NAME} failed: ${err.message}`);
  } finally {
    console.log(`🍔 ${process.env.APPLICATION_NAME} has finished.`);
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
