import CrudHttpClient from '@/services/CrudHttpClient'
import marked from 'marked'

class ArticleService extends CrudHttpClient {
  constructor() {
    super('article')
  }

  parseMarkdown(markdownCode) {
    return marked(markdownCode)
  }
}

export default new ArticleService()
