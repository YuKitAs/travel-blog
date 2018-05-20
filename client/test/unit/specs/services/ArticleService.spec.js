import ArticleService from '@/services/ArticleService'

const LIMIT = 10
const OFFSET = 30
const QUERY_PARAMS = {limit: LIMIT, offset: OFFSET}
const QUERY_PARAMS_IN_URL = `?limit=${LIMIT}&offset=${OFFSET}`
const RESPONSE = { valid: 'json' }
const RESPONSE_STRING = JSON.stringify(RESPONSE)

describe('ArticleService', () => {
  it('builds correct url with its resource name', () => {
    expect(ArticleService.buildUrl()).to.equal('api/articles')
    expect(ArticleService.buildUrl('article-id')).to.equal('api/articles/article-id')
  })

  it('gets many objects', async () => {
    const server = sinon.createFakeServer()
    server.autoRespond = true

    server.respondWith('GET', `api/articles/preview${QUERY_PARAMS_IN_URL}`,
      [200, { 'Content-Type': 'application/json' }, RESPONSE_STRING])

    const response = await ArticleService.getMany(QUERY_PARAMS)

    expect(response.status).to.equal(200)
    expect(response.data).to.eql(RESPONSE)

    server.restore()
  })
})
