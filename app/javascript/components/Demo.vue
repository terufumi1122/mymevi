<template>
  <v-content>
    <v-container class="demo__container">
      <v-row wrap>
        <v-col>
          <div class="demo__field">
            <div class="dammy__square">
            </div>
          </div>
          <p>this is Demo.vue</p>
        </v-col>
      </v-row>
    </v-container>
  </v-content>
</template>

<script>
  export default {
    name: 'Demo',
    data() {
      return {
      }
    },
  }
</script>

<style scoped>
  .demo__field {
    margin: 0 auto;
  }
  .dammy__square {
    width: 200px;
    height: 300px;
  }
</style>