import CrudHttpClient from '@/services/CrudHttpClient'

class TagService extends CrudHttpClient {
  constructor() {
    super('tag')
  }

  getByArticleId(articleId) {
    return this.getMany({article_id: articleId})
  }
}

export default new TagService()
