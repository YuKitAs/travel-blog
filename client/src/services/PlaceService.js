import CrudHttpClient from '@/services/CrudHttpClient'

class PlaceService extends CrudHttpClient {
  constructor() {
    super('place')
  }
}

export default new PlaceService()
