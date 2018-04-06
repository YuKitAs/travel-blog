import axios from 'axios';

class CrudHttpClient {
  get(url, params) {
    return axios({
      ...this.buildCommonHttpClientSettings(),
      method: 'get',
      url,
      params,
    });
  }

  put(url, data) {
    return axios({
      ...this.buildCommonHttpClientSettings(),
      method: 'put',
      url,
      data,
    });
  }

  post(url, data) {
    return axios({
      ...this.buildCommonHttpClientSettings(),
      method: 'post',
      url,
      data,
    });
  }

  delete(url, params) {
    return axios({
      ...this.buildCommonHttpClientSettings(),
      method: 'delete',
      url,
      params,
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
}

export default new CrudHttpClient();
