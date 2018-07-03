import axios from 'axios'
import CrudHttpClient from '@/services/CrudHttpClient'

class ArticleService extends CrudHttpClient {
  constructor() {
    super('article')
  }

  getMany(params) {
    return axios({
      ...this.buildCommonHttpClientSettings(),
      method: 'get',
      url: `${this.buildUrl()}/preview`,
      params
    })
  }

  getAll(start, limit) {
    return this.getMany({start, limit})
  }

  getByTags(tagIds, start, limit) {
    return this.getMany({tag_ids: tagIds, start, limit})
  }

  getFeatured() {
    return axios({
      ...this.buildCommonHttpClientSettings(),
      method: 'get',
      url: `${this.buildUrl()}/featured/preview`
    })
  }
}

export default new ArticleService()
