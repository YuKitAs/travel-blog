import CrudHttpClient from '@/services/CrudHttpClient';

const REQUEST_URL = '/some/url';
const URL_QUERY_PARAMS = '?key=value';
const QUERY_PARAMS = { key: 'value' };
const REQUEST_DATA = { key: 'value' };
const REQUEST_DATA_STRING = JSON.stringify(REQUEST_DATA);
const RESPONSE = { valid: 'json' };
const RESPONSE_STRING = JSON.stringify(RESPONSE);

describe('CrudHttpClient', () => {
  let server;

  beforeEach(() => {
    server = sinon.createFakeServer();
    server.autoRespond = true;
  });

  afterEach(() => {
    server.restore();
  });

  it('sends correct get request', async () => {
    server.respondWith('GET', `${REQUEST_URL}${URL_QUERY_PARAMS}`, [200, { 'Content-Type': 'application/json' }, RESPONSE_STRING]);

    const response = await CrudHttpClient.get(REQUEST_URL, QUERY_PARAMS);

    expect(response.status).to.equal(200);
    expect(response.data).to.eql(RESPONSE);
  });

  it('sends correct put request', async () => {
    let requestBody;

    server.respondWith('PUT', REQUEST_URL, (request) => {
      requestBody = request.requestBody;
      request.respond(200, { 'Content-Type': 'application/json' }, RESPONSE_STRING);
    });

    const response = await CrudHttpClient.put(REQUEST_URL, REQUEST_DATA);

    expect(requestBody).to.eql(REQUEST_DATA_STRING);
    expect(response.status).to.equal(200);
    expect(response.data).to.eql(RESPONSE);
  });

  it('sends correct post request', async () => {
    let requestBody;

    server.respondWith('POST', REQUEST_URL, (request) => {
      requestBody = request.requestBody;
      request.respond(200, { 'Content-Type': 'application/json' }, RESPONSE_STRING);
    });

    const response = await CrudHttpClient.post(REQUEST_URL, REQUEST_DATA);

    expect(requestBody).to.eql(REQUEST_DATA_STRING);
    expect(response.status).to.equal(200);
    expect(response.data).to.eql(RESPONSE);
  });

  it('sends correct delete request', async () => {
    server.respondWith('DELETE', `${REQUEST_URL}${URL_QUERY_PARAMS}`, [204, { 'Content-Type': 'application/json' }, '']);

    const response = await CrudHttpClient.delete(REQUEST_URL, QUERY_PARAMS);

    expect(response.status).to.equal(204);
    expect(response.data).to.equal('');
  });
});
