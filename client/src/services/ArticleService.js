import CrudHttpClient from '@/services/CrudHttpClient'

class ArticleService extends CrudHttpClient {
  constructor() {
    super('article')
  }
}

export default new ArticleService()
