<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                課外活動
            </h2>
        </template>
        <a-button @click="createRecord" type="primary">開設課外活動</a-button>
        <div>
            <div class="ant-table">
                <div class="ant-table-container">
                    <div class="ant-table-content">
                        <table style="table-layout: auto;" id="dataTable" ref="dataTable">
                            <thead class="ant-table-thead">
                                <tr>
                                    <th>Cert title</th>
                                    <th>Student Name</th>
                                    <th>Issue Date</th>
                                    <th>Issue Number</th>
                                    <th>Klass</th>
                                    <th>Student number</th>
                                    <th>Print</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="cert in certificates">
                                    <td>{{cert.certificate_meta.label}}</td>
                                    <td>{{cert.name_display}}</td>
                                    <td>{{cert.issue_date}}</td>
                                    <td>{{cert.issue_number}}</td>
                                    <td>{{cert.klass_tag}}</td>
                                    <td>{{cert.student_number}}</td>
                                    <td><a-button @click="printCertificate(cert)">Print</a-button></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        </div>

    </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import dayjs from 'dayjs';

export default {
    components: {
        AdminLayout,
        dayjs,
    },
    props: ['certificates'],
    data() {
        return {
            dateFormat:'YYYY-MM-DD',
            modal: {
                mode: null,
                isOpen: false,
                title: '課外活動',
                data: {}
            },
        }
    },
    created(){
        dayjs.locale('en');
    },

    methods: {
        printCertificate(cert){
            var data=[11,12]
            this.$inertia.post(route('admin.certificate.print'),data, {
                onSuccess: (page) => {
                    console.log(page)
                },
                onError: (error) => {
                    console.log(error);
                }
            });
            console.log(cert)
        },
        closeModal() {
            this.isOpen = false;
            this.reset();
            this.editMode = false;
        },
        createRecord() {
            this.modal.data = {};
            this.modal.mode = 'CREATE';
            this.modal.title = "開設課外活動";
            this.modal.isOpen = true;
        },
        editRecord(record) {
            this.modal.data = { ...record };
            this.modal.mode = 'EDIT';
            this.modal.title = "修改課外活動";
            this.modal.isOpen = true;
        },
        onFinish(values){
            if(this.modal.mode=='EDIT'){
                this.$inertia.put(route('admin.activities.update',this.modal.data.id),this.modal.data, {
                    onSuccess: (page) => {
                        this.modal.isOpen = false;
                    },
                    onError: (error) => {
                        console.log(error);
                    }
                });
            }
            if(this.modal.mode=='CREATE'){
                this.$inertia.post(route('admin.activities.store'),this.modal.data, {
                    onSuccess: (page) => {
                        this.modal.isOpen = false;
                    },
                    onError: (error) => {
                        console.log(error);
                    }
                });
            }
        },
    },
}
</script>
