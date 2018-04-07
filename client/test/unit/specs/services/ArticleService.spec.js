import ArticleService from '@/services/ArticleService';

describe('ArticleService', () => {
  it('builds correct url with its resource name', () => {
    expect(ArticleService.buildUrl()).to.equal('api/articles');
    expect(ArticleService.buildUrl('article-id')).to.equal('api/articles/article-id');
  });
});
