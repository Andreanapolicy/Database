const { MongoClient, ObjectId} = require('mongodb');

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

    //== Вставка 2 и бодее записей ==
    await collection.insertMany([
        {
            'room': {
                'create_date': '1991-01-26',
                'price': 102,
                'style_name': 'Такой себе стиль',
                'number': 102,
                'cleaner': {
                    'birthday': '1987-12-10',
                    'name': 'Джамшут',
                    'address': 'Азербайджанского 36',
                    'eye_color': 'смольный',
                },
            },
            'client': {
                'birthday': '1997-12-12',
                'name': 'Эдуард',
                'address': 'Комецких 1',
                'eye_color': 'зеленый',
                'car': [
                    {
                        'creation_date': '1978-12-05',
                        'name': 'Малыш',
                        'price': 12305484,
                        'rating': 12
                    }
                ]
            },
            'start_date': '2022-09-23',
            'end_date': '2023-09-26',
            'pay': 1500,
        },
        {
            'room': {
                'create_date': '2021-06-24',
                'price': 2500,
                'style_name': 'Авангард',
                'number': 736,
                'cleaner': {
                    'birthday': '1987-12-10',
                    'name': 'Рапшан',
                    'address': 'Ленового 17',
                    'eye_color': 'коричневый',
                },
            },
            'client': {
                'birthday': '1987-04-05',
                'name': 'Владимир',
                'address': 'Малевого 27',
                'eye_color': 'красный',
                'car': []
            },
            'start_date': '2022-06-15',
            'end_date': '2023-06-16',
            'pay': 300,
        },
    ]);

    //=== 3.3 Удаление записей ===

    //== Удаление 1 записи ==
    await collection.deleteOne({'pay': 300});

    //== Удаление 2 и более записи ==
    await collection.deleteMany({'pay': 6504});

    //=== 3.4 Поиск записей ===

    //== Поиск по ID ==
    console.log('Поиск по ID', await collection.findOne({'_id': ObjectId('626e84d25f21a1a868156fba')}));

    //== Записи по атрибуту первого уровня ==
    console.log('Записи по атрибуту первого уровня', await collection.findOne({'pay': 1500}));

    //== Записи по вложенному атрибуту ==
    console.log('Записи по вложенному атрибуту', await collection.findOne({'client.birthday': '1997-12-12'}));

    //== Записи по нескольким атрибутам ==
    console.log('Записи по нескольким атрибутам', await collection.findOne({'client.birthday': '1997-12-12', 'pay': 1500}));
}

main()
    .then(console.log)
    .catch(console.error)
    .finally(() => client.close());