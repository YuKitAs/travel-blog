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
