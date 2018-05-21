<template>
  <div>
    <h1 class="tb-page-title">Tags</h1>

    <div class="tb-tag-filter">
      <span
          class="tb-tag" :class="{'tb-tag--selected': !hasIdSelected()}"
          @click="clearAllSelectedIds">Clear All</span>
      <span v-for="tag in tags" :key="tag.id"
          class="tb-tag" :class="{'tb-tag--selected': isIdSelected(tag.id)}"
          @click="toggleSelectId(tag.id)">
        {{tag.name}}
      </span>
    </div>

    <article-list :article-previews="articlePreviews"/>
  </div>
</template>

<script>
import ArticleList from '@/components/common/ArticleList'

import ArticleService from '@/services/ArticleService'
import TagService from '@/services/TagService'

export default {
  props: {
    selectedTagIds: {type: Array, default: () => []}
  },

  data() {
    return {
      tags: {},
      selectedIds: this.selectedTagIds,
      articlePreviews: []
    }
  },

  async mounted() {
    await this.fetchData()
  },

  methods: {
    async fetchData() {
      const tagsResponse = await TagService.getMany()
      this.tags = tagsResponse.data

      this.fetchArticles()
    },

    async fetchArticles() {
      let articlePreviewsResponse
      if (this.hasIdSelected()) {
        articlePreviewsResponse = await ArticleService.getByTags(this.selectedIds)
      } else {
        articlePreviewsResponse = await ArticleService.getAll()
      }

      this.articlePreviews = articlePreviewsResponse.data
    },

    isIdSelected(tagId) {
      return this.selectedIds.includes(tagId)
    },

    hasIdSelected() {
      return this.selectedIds.length !== 0
    },

    async toggleSelectId(tagId) {
      if (!this.isIdSelected(tagId)) {
        this.selectedIds.push(tagId)
      } else {
        this.selectedIds = this.selectedIds.filter(selectedId => selectedId !== tagId)
      }

      this.fetchArticles()
    },

    clearAllSelectedIds() {
      this.selectedIds = []

      this.fetchArticles()
    }
  },

  components: {
    ArticleList
  }
}
</script>

<style lang="sass" scoped>
  @import "src/assets/styles/mixins"

  .tb-tag-filter
    margin-bottom: $space-width

  .tb-tag--selected
    color: $theme-color-3
    background-color: $theme-color-1
    &:hover
      text-decoration: none
      background-color: $theme-color-1-highlighted-2
      border-color: $theme-color-1-highlighted-2
</style>
