<template>
  <div>
    <div v-for="comment in comments" :key="comment.id">
      <v-card
        class="mx-auto my-3"
        max-width="374"
      >
        <div class="balloon">
          <v-card-text
            class="text--black font-weight-bold text-center"
          >
            {{ comment.content }}
          </v-card-text>
        </div>

        <v-card-actions>
          <v-list-item class="grow">

            <!-- 後でuser.eyecatchを表示する -->
            <v-list-item-avatar color="grey darken-3">
              <v-img
                class="elevation-6"
                src="https://avataaars.io/?avatarStyle=Transparent&topType=ShortHairShortCurly&accessoriesType=Prescription02&hairColor=Black&facialHairType=Blank&clotheType=Hoodie&clotheColor=White&eyeType=Default&eyebrowType=DefaultNatural&mouthType=Default&skinColor=Light"
              ></v-img>
            </v-list-item-avatar>

            <v-list-item-content>
              <v-list-item-subtitle>
                {{ comment.user_name }} さん
              </v-list-item-subtitle>
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

<style>
.balloon {
  position: relative;
  display: inline-block;
  margin: 10px;
  padding: 10px;
  width: 354px;
  color: #555;
  font-size: 16px;
  background: #e0edff;
  box-shadow: 0 0 3px rgba(0,0,0,.3);
}

.balloon:before {
  content: "";
  position: absolute;
  top: 100%;
  left: 33px;
  margin-left: -15px;
  border: 15px solid transparent;
  border-top: 15px solid #e0edff;
}

</style>