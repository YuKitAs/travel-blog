export default {
  buildResponse(statusCode, data) {
    return Promise.resolve({status: statusCode, data})
  }
}
