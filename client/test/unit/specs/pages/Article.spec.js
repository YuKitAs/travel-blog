/* global fixture */
import Article from '@/pages/Article'
import ArticleService from '@/services/ArticleService'
import PlaceService from '@/services/PlaceService'
import TagService from '@/services/TagService'
import ArticleSelectors from '@test/selector/pages/Article'
import utilities from '@test/unit/utilities'
import VueTestComponentWrapper from 'vue-test-component-wrapper'

describe('Article', () => {
  let wrapper
  let sandbox
  let ARTICLE_ID, ARTICLE, PLACE, TAGS

  beforeEach(async () => {
    sandbox = sinon.createSandbox()

    ARTICLE_ID = 'article-id'
    ARTICLE = fixture.load('articles.json').article
    PLACE = fixture.load('places.json').place
    TAGS = [fixture.load('tags.json').tag, fixture.load('tags.json').new_tag]

    sandbox.stub(ArticleService, 'getOne').withArgs(ARTICLE_ID).returns(utilities.buildResponse(200, ARTICLE))
    sandbox.stub(PlaceService, 'getOne').returns(utilities.buildResponse(200, PLACE))
    sandbox.stub(TagService, 'getByArticleId').returns(utilities.buildResponse(200, TAGS))

    wrapper = await VueTestComponentWrapper.mounted(Article, {articleId: ARTICLE_ID})
  })

  afterEach(() => {
    sandbox.restore()
  })

  it('displays correct content', () => {
    expect(wrapper.getTextContent(ArticleSelectors.title)).to.equal(ARTICLE.title)
    expect(wrapper.getTextContent(ArticleSelectors.metadata)).to.contain('Apr. 6, 2018')
    expect(wrapper.getTextContent(ArticleSelectors.metadata)).to.contain(PLACE.name)
    expect(wrapper.getTextContents(ArticleSelectors.tags)).to.eql(TAGS.map(tag => tag.name))
    expect(wrapper.getHtmlContent(ArticleSelectors.content))
      .to.contain('Lorem <strong>ipsum</strong> dolor sit amet')
  })
})
