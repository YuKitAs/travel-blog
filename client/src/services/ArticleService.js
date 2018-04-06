import CrudHttpClient from '@/services/CrudHttpClient';

class ArticleService extends CrudHttpClient {
  constructor() {
    super('articles');
  }
}

export default new ArticleService();
