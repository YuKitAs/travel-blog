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
}

export default new ArticleService()
