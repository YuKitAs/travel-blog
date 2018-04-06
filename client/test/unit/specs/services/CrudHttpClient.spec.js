import CrudHttpClient from '@/services/CrudHttpClient';

const RESOURCE_PLURAL_NAME = 'entities';
const RESOURCE_PLURAL_URL = 'api/entities';
const LIMIT = 10;
const OFFSET = 30;
const QUERY_PARAMS = `?limit=${LIMIT}&offset=${OFFSET}`;
const RESOURCE_ID = 'resource-id';
const RESOURCE_SINGULAR_URL = `api/entities/${RESOURCE_ID}`;
const RESPONSE = { valid: 'json' };
const RESPONSE_STRING = JSON.stringify(RESPONSE);
const QUERY_DATA = { id: 'random-id', key: 'value' };
const QUERY_DATA_WITHOUT_ID = { key: 'value' };

describe('CrudHttpClient', () => {
  let server;
  let crudHttpClient;

  beforeEach(() => {
    server = sinon.createFakeServer();
    server.autoRespond = true;

    crudHttpClient = new CrudHttpClient(RESOURCE_PLURAL_NAME);
  });

  afterEach(() => {
    server.restore();
  });

  it('gets one object', async () => {
    server.respondWith('GET', RESOURCE_SINGULAR_URL, [200, { 'Content-Type': 'application/json' }, RESPONSE_STRING]);

    const response = await crudHttpClient.getOne(RESOURCE_ID);

    expect(response.status).to.equal(200);
    expect(response.data).to.eql(RESPONSE);
  });

  it('gets many objects', async () => {
    server.respondWith('GET', `${RESOURCE_PLURAL_URL}${QUERY_PARAMS}`, [200, { 'Content-Type': 'application/json' }, RESPONSE_STRING]);

    const response = await crudHttpClient.getMany(LIMIT, OFFSET);

    expect(response.status).to.equal(200);
    expect(response.data).to.eql(RESPONSE);
  });

  it('creates object', async () => {
    let requestBody;

    server.respondWith('PUT', RESOURCE_PLURAL_URL, (request) => {
      requestBody = request.requestBody;
      request.respond(200, { 'Content-Type': 'application/json' }, RESPONSE_STRING);
    });

    const response = await crudHttpClient.create(QUERY_DATA);

    expect(JSON.parse(requestBody)).to.eql(QUERY_DATA_WITHOUT_ID);
    expect(response.status).to.equal(200);
    expect(response.data).to.eql(RESPONSE);
  });

  it('updates entity', async () => {
    let requestBody;

    server.respondWith('POST', RESOURCE_SINGULAR_URL, (request) => {
      requestBody = request.requestBody;
      request.respond(200, { 'Content-Type': 'application/json' }, RESPONSE_STRING);
    });

    const response = await crudHttpClient.update(RESOURCE_ID, QUERY_DATA);

    expect(JSON.parse(requestBody)).to.eql(QUERY_DATA_WITHOUT_ID);
    expect(response.status).to.equal(200);
    expect(response.data).to.eql(RESPONSE);
  });

  it('deletes object', async () => {
    server.respondWith('DELETE', RESOURCE_SINGULAR_URL, [200, { 'Content-Type': 'application/json' }, RESPONSE_STRING]);

    const response = await crudHttpClient.delete(RESOURCE_ID);

    expect(response.status).to.equal(200);
    expect(response.data).to.eql(RESPONSE);
  });
});
