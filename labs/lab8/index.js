const { MongoClient } = require('mongodb');

// Connection URL
const url = 'mongodb://localhost:27017';
const client = new MongoClient(url);

// Database Name
const dbName = 'CarHotel';

async function main()
{
    await client.connect();
    console.log('Connected successfully to server');
    const db = client.db(dbName);
    const collection = db.collection('booking');

    //=== 3.1 Отобразить коллекции базы данных ===
    console.log(collection);

    //=== 3.2 Вставка записей ===

    //== Вставка 1 записи ==
    collection.insertOne({

    });

    return 'done.';
}

main()
    .then(console.log)
    .catch(console.error)
    .finally(() => client.close());