import TagService from '@/services/TagService'

describe('TagService', () => {
  it('builds correct url with its resource name', () => {
    expect(TagService.buildUrl()).to.equal('api/tags')
    expect(TagService.buildUrl('tag-id')).to.equal('api/tags/tag-id')
  })

  it('sends correct data while getting tags by artcile ID', () => {
    sinon.stub(TagService, 'getMany').returns('response')
    const response = TagService.getByArticleId('article-id')

    expect(TagService.getMany).to.calledWith({article_id: 'article-id'})
    expect(response).to.equal('response')
  })
})
