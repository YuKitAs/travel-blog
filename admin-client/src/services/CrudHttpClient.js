import axios from 'axios'
import pluralize from 'pluralize'
import qs from 'qs'

export default class CrudHttpClient {
  constructor(resourceName) {
    this.resourceName = resourceName
    this.resourcePluralName = pluralize(resourceName)
  }

  buildUrl(id) {
    const idSuffix = id ? `/${id}` : ''
    return `api/${this.resourcePluralName}${idSuffix}`
  }

  getOne(id) {
    return axios({
      ...this.buildCommonHttpClientSettings(),
      method: 'get',
      url: this.buildUrl(id)
    })
  }

  getMany(params) {
    return axios({
      ...this.buildCommonHttpClientSettings(),
      method: 'get',
      url: this.buildUrl(),
      params
    })
  }

  post(data) {
    return axios({
      ...this.buildCommonHttpClientSettings(),
      method: 'post',
      url: this.buildUrl(),
      data
    })
  }

  put(id, data) {
    return axios({
      ...this.buildCommonHttpClientSettings(),
      method: 'put',
      url: this.buildUrl(id),
      data
    })
  }

  delete(id) {
    return axios({
      method: 'delete',
      url: this.buildUrl(id)
    })
  }

  buildCommonHttpClientSettings() {
    return {
      headers: {
        'Content-Type': 'application/json'
      },
      timeout: 5000,
      paramsSerializer: (params) => {
        return qs.stringify(params, { arrayFormat: 'brackets', encode: false })
      }
    }
  }
}
