<template>
  <v-dialog v-model="dialog" persistent>
    <v-card>
      <v-card-title>{{ title }}</v-card-title>
      <v-row>
        <v-col>
        <v-slider
          class="mt-4"
          v-model="slider"
          :max="max"
          :min="min"
          :thumb-size="35"
          thumb-label="always"
          hide-details
          @end="$emit('end', slider)"
        ></v-slider>
        </v-col>
      </v-row>
        <v-card-actions>
            <v-btn
              color="#990011"
              dark
              @click="$emit('close-dialog')"
            >閉じる</v-btn>
        </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script>
  export default {
    data () {
      return {
        slider: 1000,
      }
    },
    props: {
      dialog: Boolean,
      title: String,
      max: Number,
      min: Number,
    }
  }
</script>