import CrudHttpClient from '@/services/CrudHttpClient'

class TagService extends CrudHttpClient {
  constructor() {
    super('tag')
  }
}

export default new TagService()
