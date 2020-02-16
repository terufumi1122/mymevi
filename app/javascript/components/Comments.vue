<template>
  <div>
    <div v-for="comment in comments" :key="comment.id">
      <v-card
        class="mb-3 mx-3"
        max-width="400"
      >

        <v-card-text>
          {{ comment.content }}
        </v-card-text>

        <v-card-actions>
          <v-list-item class="grow">
            <v-list-item-avatar color="grey darken-3">
              <v-img
                class="elevation-6"
                src="https://avataaars.io/?avatarStyle=Transparent&topType=ShortHairShortCurly&accessoriesType=Prescription02&hairColor=Black&facialHairType=Blank&clotheType=Hoodie&clotheColor=White&eyeType=Default&eyebrowType=DefaultNatural&mouthType=Default&skinColor=Light"
              ></v-img>
            </v-list-item-avatar>

            <v-list-item-content>
              <v-list-item-title>{{ comment.user_id }}</v-list-item-title>
            </v-list-item-content>

          </v-list-item>
        </v-card-actions>
      </v-card>
    </div>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex' 

  export default {
    name: 'Comments',
    computed: {
      ...mapGetters([
        'comments'
      ])
    }
  }
</script>