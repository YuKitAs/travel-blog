export default {
  buildResponse(statusCode, data) {
    if (statusCode >= 200 && statusCode < 300) {
      return Promise.resolve({status: statusCode, data})
    } else {
      // eslint-disable-next-line
      return Promise.reject({status: statusCode, data})
    }
  }
}
