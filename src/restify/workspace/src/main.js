const path = require('path');
const low = require('lowdb');
const express = require('express');
const FileSyncAdapter = require('lowdb/adapters/FileSync');

const database = (file, data = {}) => {
  const db = low(new FileSyncAdapter(file));
  const ts = parseInt(Date.now() / 1000);
  db.defaults(Object.assign(data, { ts })).write();
  return db;
};

const meta = database(path.join(process.cwd(), 'meta.json'));

const app = express();

const port = process.env.SERVER_PORT || 5000;

app.get('/', (req, res) => {
  res.json({})
});

app.get(['/_cat', '/_cat/api'], (req, res) => {
  const items = meta.get('_api').value();
  const result = { items, count: items.length };
  res.send({
    code: 0,
    payload: Object.assign({ category: 'api' }, result)
  })
});

app.route('/collections')
  .get((req, res) => {
    const store = database(req.query.db);
    const values = store.value();
    const collections = [];
    for (let [key, value] of Object.entries(values)) {
      if (Array.isArray(value)) {
        collections.push(key);
      }
    }
    res.send({
      code: 0,
      payload: {
        category: 'collections',
        items: collections,
        count: (collections || []).length
      }
    })
  })
  .post((req, res) => {
    res.send('hello');
  });

app.route('/collection/:unique')
  .get((req, res) => {
    const { unique } = req.params;
    const store = database(req.query.db);
    const values = store.get(unique).value();
    res.send({
      code: 0,
      payload: {
        category: 'collection',
        collection: unique,
        items: values,
        count: (values || []).length
      }
    })
  })
  .post((req, res) => {
    res.send('hello');
  })  
  .delete((req, res) => {
    res.send('hello');
  });

app.route('/collection/:unique/:id')
  .get((req, res) => {
    const idField = req.query.id || 'id';
    const { unique, id } = req.params;
    const params = { [idField]: id };
    const store = database(req.query.db);
    const document = store.get(unique).find(params).value();
    res.send({
      code: 0,
      payload: {
        category: 'document',
        collection: unique,
        id,
        document
      }
    })
  })
  .put((req, res) => {
    res.send('hello');
  })
  .delete((req, res) => {
    res.send('hello');
  });

app.get('/values', (req, res) => {
  const store = database(req.query.db);
  const values = store.value();
  const result = {};
  for (let [key, value] of Object.entries(values)) {
    if (!Array.isArray(value)) {
      result[key] = value;
    }
  }
  res.send({
    code: 0,
    payload: {
      category: 'values',
      value: result
    }
  })
});

app.get('/value/:unique', (req, res) => {
  const { unique } = req.params;
  const store = database(req.query.db);
  const value = store.get(unique).value();
  res.send({
    code: 0,
    payload: {
      category: 'value',
      key: unique,
      value
    }
  })
});

app.listen(port, () => {
  console.log(`Restify run on port ${port}`)
})