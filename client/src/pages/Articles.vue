<template>
  <div class="tb-articles">
    <h1 class="tb-page-title">Articles</h1>
    <featured-article/>
    <article-list :article-previews="articlePreviews"/>
  </div>
</template>

<script>
import ArticleList from '@/components/common/ArticleList'
import FeaturedArticle from '@/components/articles/FeaturedArticle'

import ArticleService from '@/services/ArticleService'

export default {
  data() {
    return {
      articlePreviews: []
    }
  },

  async mounted() {
    await this.fetchData()
  },

  methods: {
    async fetchData() {
      try {
        this.articlePreviews = (await ArticleService.getAll()).data
      } catch (e) {
        this.$router.replace({name: 'Error'})
      }
    }
  },

  components: {
    ArticleList,
    FeaturedArticle
  }
}
</script>
