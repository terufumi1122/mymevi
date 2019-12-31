<template>
  <v-content>
    <v-container class="about__wrapper">
      <v-row>
        <v-spacer></v-spacer>
        <img src="../../assets/images/sample_logo.png" alt="メインロゴ">
        <v-spacer></v-spacer>
      </v-row>
      <v-row>
        <v-spacer></v-spacer>
        <p><strong>マイメビ</strong>は、みんながうまくいった習慣を共有するサービスです。</p>
        <v-spacer></v-spacer>
      </v-row>
      <v-row>
        <v-spacer></v-spacer>
        <Button/>
        <v-spacer></v-spacer>
        <Button
          buttonName="サインアップ"
        />
        <v-spacer></v-spacer>
      </v-row>
    </v-container>
  </v-content>
</template>

<script>
  import Button from './Button.vue'

  export default {
    name: 'About',
    components: {
      Button,
    }
  }
</script>

<style scoped>
  .about__wrapper {
    background: #aaa;
    text-align: center;
  }
</style>