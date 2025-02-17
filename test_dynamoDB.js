const { DynamoDBClient } = require("@aws-sdk/client-dynamodb");
const { DynamoDBDocumentClient } = require("@aws-sdk/lib-dynamodb");
const { ListTablesCommand } = require("@aws-sdk/client-dynamodb");
const config = require("./aws");

const client = new DynamoDBClient(config.credential);
const ddbClient = DynamoDBDocumentClient.from(client);

// Fungsi untuk menguji koneksi dan mencetak daftar tabel
async function listTables() {
  try {
    const data = await ddbClient.send(new ListTablesCommand({}));
    console.log("Tables in DynamoDB:", data.TableNames);
  } catch (error) {
    console.error("Error listing tables:", error);
  }
}

// Panggil fungsi listTables untuk pengujian
listTables();
