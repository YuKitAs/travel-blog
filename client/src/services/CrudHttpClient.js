import _ from 'lodash';
import axios from 'axios';

export default class CrudHttpClient {
  constructor(resourcePluralName) {
    this.resourcePluralName = resourcePluralName;
  }

  buildUrl(id) {
    const idSuffix = id ? `/${id}` : '';
    return `api/${this.resourcePluralName}${idSuffix}`;
  }

  getOne(id) {
    return axios({
      ...this.buildCommonHttpClientSettings(),
      method: 'get',
      url: this.buildUrl(id),
    });
  }

  getMany(limit = 10, offset = 0) {
    return axios({
      ...this.buildCommonHttpClientSettings(),
      method: 'get',
      url: this.buildUrl(),
      params: { limit, offset },
    });
  }

  create(data) {
    return axios({
      ...this.buildCommonHttpClientSettings(),
      method: 'put',
      url: this.buildUrl(),
      data: this.removeId(data),
    });
  }

  update(id, data) {
    return axios({
      ...this.buildCommonHttpClientSettings(),
      method: 'post',
      url: this.buildUrl(id),
      data: this.removeId(data),
    });
  }

  delete(id) {
    return axios({
      ...this.buildCommonHttpClientSettings(),
      method: 'delete',
      url: this.buildUrl(id),
    });
  }

  buildCommonHttpClientSettings() {
    return {
      headers: {
        'Content-Type': 'application/json',
      },
      timeout: 5000,
    };
  }

  removeId(data) {
    const clonedData = _.cloneDeep(data);
    delete clonedData.id;

    return clonedData;
  }
}
