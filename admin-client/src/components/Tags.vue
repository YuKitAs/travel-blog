<template>
  <b-container fluid>
    <b-row>
      <b-col md="4">
        <b-form-group>
          <b-input-group>
            <b-form-input v-model="filter" placeholder="Search..." />
            <b-input-group-append>
              <b-btn :disabled="!filter" @click="filter = ''">Clear</b-btn>
            </b-input-group-append>
          </b-input-group>
        </b-form-group>
      </b-col>
    </b-row>

    <b-row>
      <b-col>
        <b-form-group>
          <b-btn size="sm" v-b-modal.new-tag>Add</b-btn>
        </b-form-group>
      </b-col>
    </b-row>

    <b-table hover :items="items" :fields="fields" :filter="filter">
      <template slot="actions" slot-scope="row">
         <b-btn size="sm" v-b-modal.edit-tag @click.stop="selectTag(row.item)">Edit</b-btn>
         <b-btn size="sm" v-b-modal.delete-tag-confirm  @click.stop="selectTag(row.item)">Delete</b-btn>
      </template>
    </b-table>

    <b-modal id="new-tag" title="Create a new tag" no-fade @shown="focusTagName" @ok="addTag">
      <b-col md="10">
        <label>Tag name</label>
        <b-form-input ref="tagName" v-model="newTag"/>
      </b-col>
    </b-modal>

    <b-modal id="edit-tag" title="Edit tag" no-fade ok-title="Update" @shown="focusTagName" @ok="updateTag">
      <b-col md="10">
        <label>Tag name</label>
        <b-form-input ref="tagName" v-model="selectedTagName"/>
      </b-col>
    </b-modal>

    <b-modal id="delete-tag-confirm" title="Delete tag" no-fade ok-title="Confirm" @ok="removeTag">
      <b-col md="10">
        <div>Are you sure to delete the tag <span id="selected-tag-name">{{selectedTagName}}</span>?</div>
      </b-col>
    </b-modal>
  </b-container>
</template>

<script>
export default {
  name: 'Tags',
  data() {
    return {
      fields: [
        { key: 'name', sortable: true, sortDirection: 'asc' },
        { key: 'actions' }
      ],
      items: [
        { id: 0, name: 'City' },
        { id: 1, name: 'Nature' },
        { id: 2, name: 'Hiking' },
        { id: 3, name: 'Cycling' },
        { id: 4, name: 'Driving' }
      ],
      filter: null,
      newTag: '',
      selectedTag: {},
      selectedTagName: ''
    }
  },
  methods: {
    focusTagName(e) {
      this.$refs.tagName.focus()
    },
    addTag() {
      this.items.push({ id: Math.floor((Math.random() * 100) + 1), name: this.newTag })
      this.newTag = ''
    },
    selectTag(item) {
      this.selectedTag = item
      this.selectedTagName = item.name
    },
    updateTag() {
      let tag = this.items.find(t => t.id === this.selectedTag.id)
      if (tag) {
        tag.name = this.selectedTagName
      }
    },
    removeTag() {
      let id = this.items.findIndex(t => t.id === this.selectedTag.id)
      if (id !== -1) {
        this.items.splice(id, 1)
      }
    }
  }
}
</script>

<style scoped>
label {
  margin-bottom: 10px;
}

#selected-tag-name {
  font-weight: 600;
}
</style>
