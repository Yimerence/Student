<template>
  <div>
    <div class="card" style="width: 50%;padding: 40px">
      <el-form :model="data.form" ref="formRef" label-width="100px" label-position="right" style="padding-right: 40px">
        <el-form-item label="学生头像">
          <el-upload class="avatar-uploader" action="http://localhost:9090/files/upload" :show-file-list="false"
                     :on-success="handleImgUploadSuccess">
            <img v-if="data.form.avatar" :src="data.form.avatar" class="avatar" >
<!--            <i v-else class="el-icon-plus avatar-uploader-icon"></i>-->
            <el-icon v-else class="avatar-uploader-icon"><Plus /></el-icon>
          </el-upload>
        </el-form-item>
        <el-form-item label="学生账号" prop="username">
          <el-input v-model="data.form.username" autocomplete="off"/>
        </el-form-item>
        <el-form-item label="学生密码" prop="password">
          <el-input show-password v-model="data.form.password" autocomplete="off" disabled/>
        </el-form-item>
        <el-form-item label="学生名称">
          <el-input v-model="data.form.name" autocomplete="off"/>
        </el-form-item>
        <el-form-item label="手机号">
          <el-input v-model="data.form.phone" autocomplete="off"/>
        </el-form-item>
        <el-form-item label="邮箱">
          <el-input v-model="data.form.email" autocomplete="off"/>
        </el-form-item>
        <el-form-item label="性别" >
          <el-radio-group v-model="data.form.sex" class="ml-4">
            <el-radio label="男"></el-radio>
            <el-radio label="女"></el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="生日">
          <el-date-picker format="YYYY-MM-DD" value-format="YYYY-MM-DD" v-model="data.form.birth"></el-date-picker>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="update">保存</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script setup>
import {reactive} from "vue";
import {ElMessage} from "element-plus";
import router from "../../router";
import request from "../../utils/request";
import {Plus} from "@element-plus/icons-vue"

const data = reactive({
  form:JSON.parse(localStorage.getItem('student-user')||"{}")//用缓存获取当前登录用户的信息
})

const handleImgUploadSuccess = (res) => {
  data.form.avatar = res.data
}

const update = () =>{
  request.put('/student/update',data.form).then(res =>{
    if (res.code === '200') {
      ElMessage.success("操作成功")
      router.push('/login')//更新之后重新登录
    } else {
      ElMessage.error(res.msg)
    }
  })
}
</script>

<style>
.avatar-uploader .el-upload {
  border: 1px dashed var(--el-border-color);
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  transition: var(--el-transition-duration-fast);
}

.avatar-uploader .el-upload:hover {
  border-color: var(--el-color-primary);
}

.el-icon.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 100px;
  height: 100px;
  text-align: center;
}
.avatar{
  width: 100px;
  height: 100px;
  display: block;
}
</style>