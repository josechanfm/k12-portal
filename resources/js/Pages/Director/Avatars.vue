<template>
    <AdminLayout title="Dashboard">
        Avatars
        <a-row>
            <a-col :span="6">
                <div class="flex items-center justify-center w-full">
            <label for="dropzone-file"
                class="flex flex-col items-center justify-center w-full h-64 border-2 border-gray-300 border-dashed rounded-lg cursor-pointer bg-gray-50 dark:hover:bg-bray-800 dark:bg-gray-700 hover:bg-gray-100 dark:border-gray-600 dark:hover:border-gray-500 dark:hover:bg-gray-600">
                <div class="flex flex-col items-center justify-center pt-5 pb-6">
                    <svg class="w-8 h-8 mb-4 text-gray-500 dark:text-gray-400" aria-hidden="true"
                        xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 20 16">
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M13 13h3a3 3 0 0 0 0-6h-.025A5.56 5.56 0 0 0 16 6.5 5.5 5.5 0 0 0 5.207 5.021C5.137 5.017 5.071 5 5 5a4 4 0 0 0 0 8h2.167M10 15V6m0 0L8 8m2-2 2 2" />
                    </svg>
                    <p class="mb-2 text-sm text-gray-500 dark:text-gray-400"><span class="font-semibold">Click to
                            upload</span> or drag and drop</p>
                    <p class="text-xs text-gray-500 dark:text-gray-400">SVG, PNG, JPG or GIF (MAX. 800x400px)</p>
                </div>
                <input id="dropzone-file" type="file" ref="fileInput" multiple class="hidden" @change="handleFileChange" />
            </label>
        </div>

            </a-col>
            <a-col :span="18">
                <div class="grid grid-cols-8 gap-4">
                <div v-for="avatar in avatars">
                    <img :src="avatar.url" width="100"/>
                    {{ avatar.full_tag }}
                    {{ avatar.student_name }}
                </div>
            </div>

            </a-col>
        </a-row>

    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { InboxOutlined } from '@ant-design/icons-vue';
import { AvatarGroup, message } from 'ant-design-vue';

export default {
    components: {
        AdminLayout,
        InboxOutlined,
        message
    },
    props: [],
    data() {
        return {
            avatars: [],
            dragging: false,
        }
    },
    created() {
    },
    mounted() {

    },
    methods: {

        handleDragEnter(event) {
            event.preventDefault();
            this.dragging = true;
        },
        handleDragOver(event) {
            event.preventDefault();
        },
        handleDragLeave() {
            this.dragging = false;
        },
        handleDrop(event) {
            event.preventDefault();
            this.dragging = false;
            const file = event.dataTransfer.files[0];
            this.handleFile(file);
        },
        handleFileChange() {
            var files = this.$refs.fileInput.files;
            Object.entries(files).forEach(([i,file])=>{
                this.verifyFile(file)
            })
        },
        uploadFile(klassStudentId, file){
            axios.post(route('director.avatars.store'),{
                avatar:file,
                klassStudentId:klassStudentId
            },{
            headers: {
                'Content-Type': 'multipart/form-data'
                }
            }).then(resp=>{
                this.avatars.push(resp.data)
            }).catch(err=>{
                console.log(err);
            })

        },
        handleFile(file) {
            // Perform any necessary file handling logic
            console.log(file);
        },
        openFileDialog() {
            this.$refs.fileInput.click();
        },
        handleChange(info) {
            //console.log(info.file, info.fileList);
            const status = info.file.status

            if (status !== 'uploading') {
                console.log('uploading')
            }
            if (status === 'done') {
                message.success(`${info.file.name} file uploaded successfully.`);
            } else if (status === 'error') {
                message.error(`${info.file.name} file upload failed.`);
            }
        },
        verifyFile(file) {
            console.log(file);
            const isJpgOrPng = file.type === 'image/jpeg' || file.type === 'image/png';
            if (!isJpgOrPng) {
                message.error('You can only upload JPG file!');
            }
            const isLt2M = file.size / 1024 / 1024 < 2;
            if (!isLt2M) {
                message.error('Image must smaller than 2MB!');
            }

            axios.get(route('avatar.verifyFilename', {
                filename: file.name
            }),).then(res => {
                console.log(res.data);
                this.uploadFile(res.data.pivot.klass_student_id,file)
            })
            //return isJpgOrPng && isLt2M;
        },
        handleDrop() {
            console.log('handle drop');
        }
    },
}
</script>
