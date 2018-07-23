import axios from 'axios'

class UserService {
  post(data) {
    return axios({
      ...this.buildCommonHttpClientSettings(),
      method: 'post',
      url: 'api/login',
      data
    })
  }

  buildCommonHttpClientSettings() {
    return {
      headers: {
        'Content-Type': 'application/json'
      },
      timeout: 5000
    }
  }
}

export default new UserService()
