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
    await collection.insertOne({
        'room': {
            'create_date': '2022-04-05',
            'price': 500,
            'style_name': 'Андреанский стиль',
            'number': 301,
            'cleaner': {
                'birthday': '1987-12-10',
                'name': 'Ашот',
                'address': 'Ленового 8',
                'eye_color': 'черный',
            },
        },
        'client': {
            'birthday': '1987-04-05',
            'name': 'Антон',
            'address': 'Урчалово 8',
            'eye_color': 'зеленый',
            'car': [
                {
                    'creation_date': '2022-04-05',
                    'name': 'Урчатель',
                    'price': 20000,
                    'rating': 1
                }
            ]
        },
        'start_date': '2023-04-05',
        'end_date': '2023-05-05',
        'pay': 6504,
    });

    return 'done.';
}

main()
    .then(console.log)
    .catch(console.error)
    .finally(() => client.close());