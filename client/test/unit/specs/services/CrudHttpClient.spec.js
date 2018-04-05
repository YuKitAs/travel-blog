import CrudHttpClient from '@/services/CrudHttpClient';

const REQUEST_URL = '/some/url';
const URL_QUERY_PARAMS = '?key=value';
const QUERY_PARAMS = { key: 'value' };
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
});
