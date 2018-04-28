<template>
  <div>
    <h1>{{article.title}}</h1>
    <div v-html="parsedContent"></div>
  </div>
</template>

<script>
import ArticleService from '@/services/ArticleService'

export default {
  props: {
    articleId: {type: String, required: true}
  },

  data() {
    return {
      article: {
        title: '',
        content: ''
      }
    }
  },

  created() {
    this.loadData()
  },

  computed: {
    parsedContent() {
      return ArticleService.parseMarkdown(this.article.content)
    }
  },

  methods: {
    async loadData() {
      let response = await ArticleService.getOne(this.articleId)
      this.article = response.data
    }
  }
}
</script>
