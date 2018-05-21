<template>
  <div>
    <div>
      <a @click.stop="navigateToDate()">{{date | date}}</a> | <a @click.stop="navigateToPlace()">{{place.name}}</a>
    </div>
    <div class="tb-tag-list">
      <a v-for="tag in tags" :key="tag.id" @click.stop="navigateToTag(tag)" class="tb-tag">{{tag.name}}</a>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    date: {type: String, required: true},
    place: {type: Object, required: true},
    tags: {type: Array, default: () => []}
  },

  methods: {
    navigateToDate() {
    },

    navigateToPlace() {
    },

    navigateToTag(tag) {
      this.$router.push({name: 'Tags', params: {selectedTagIds: [tag.id]}})
    }
  }
}
</script>

<style lang="sass" scoped>
  @import "src/assets/styles/mixins"

  .tb-tag-list
    margin-top: 10px
</style>
