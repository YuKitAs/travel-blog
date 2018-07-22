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

    <b-table hover :items="items" :fields="fields" :filter="filter">
      <template slot="actions" slot-scope="row">
         <b-button size="sm" @click.stop="edit(row.item)">Edit</b-button>
         <b-button size="sm" @click.stop="remove(row.item)">Delete</b-button>
      </template>
    </b-table>
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
      filter: null
    }
  },
  methods: {
    edit(item) {
      console.log('Edit button clicked!')
      console.log(`Tag ${item.name} is going to be edited.`)
    },
    remove(item) {
      console.log('Delete button clicked!')
      console.log(`Tag ${item.name} is going to be deleted.`)
    }
  }
}
</script>

<style scoped>

</style>
