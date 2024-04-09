exports.handler = async (event) => {
    console.log("EventBridge event received:", JSON.stringify(event, null, 2));
    return {
        statusCode: 200,
        body: JSON.stringify({ message: "Event processed" }),
    };
};
