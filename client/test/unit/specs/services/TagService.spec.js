import TagService from '@/services/TagService'

describe('TagService', () => {
  let sandbox

  beforeEach(() => {
    sandbox = sinon.createSandbox()
  })

  afterEach(() => {
    sandbox.restore()
  })

  it('builds correct url with its resource name', () => {
    expect(TagService.buildUrl()).to.equal('api/tags')
    expect(TagService.buildUrl('tag-id')).to.equal('api/tags/tag-id')
  })
})
