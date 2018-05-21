import CrudHttpClient from '@/services/CrudHttpClient'

const RESOURCE_PLURAL_NAME = 'entities'
const RESOURCE_PLURAL_URL = 'api/entities'
const LIMIT = 10
const OFFSET = 30
const QUERY_PARAMS = {limit: LIMIT, offset: OFFSET}
const QUERY_PARAMS_IN_URL = `?limit=${LIMIT}&offset=${OFFSET}`
const RESOURCE_ID = 'resource-id'
const RESOURCE_SINGULAR_URL = `api/entities/${RESOURCE_ID}`
const RESPONSE = { valid: 'json' }
const RESPONSE_STRING = JSON.stringify(RESPONSE)

describe('CrudHttpClient', () => {
  let server
  let crudHttpClient

  beforeEach(() => {
    server = sinon.createFakeServer()
    server.autoRespond = true

    crudHttpClient = new CrudHttpClient(RESOURCE_PLURAL_NAME)
  })

  afterEach(() => {
    server.restore()
  })

  it('gets one object', async () => {
    server.respondWith('GET', RESOURCE_SINGULAR_URL, [200, { 'Content-Type': 'application/json' }, RESPONSE_STRING])

    const response = await crudHttpClient.getOne(RESOURCE_ID)

    expect(response.status).to.equal(200)
    expect(response.data).to.eql(RESPONSE)
  })

  it('gets many objects', async () => {
    server.respondWith('GET', `${RESOURCE_PLURAL_URL}${QUERY_PARAMS_IN_URL}`,
      [200, { 'Content-Type': 'application/json' }, RESPONSE_STRING])

    const response = await crudHttpClient.getMany(QUERY_PARAMS)

    expect(response.status).to.equal(200)
    expect(response.data).to.eql(RESPONSE)
  })
})
