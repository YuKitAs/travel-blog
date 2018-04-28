import CrudHttpClient from '@/services/CrudHttpClient'
import marked from 'marked'

class ArticleService extends CrudHttpClient {
  constructor() {
    super('articles')
  }

  parseMarkdown(markdownCode) {
    return marked(markdownCode)
  }
}

export default new ArticleService()
