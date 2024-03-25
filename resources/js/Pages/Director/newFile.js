export default (await import('vue')).defineComponent({
components: {
AdminLayout, ButtonLink, KlassSelector
},
props: ['year', 'klass', 'year_terms', 'transcripts', 'behaviours'],
data() {
return {
columns: [
{
title: 'Staff #',
dataIndex: 'staff_code',
}, {
title: 'Name',
dataIndex: 'name_zh',
}, {
title: 'Subject',
dataIndex: 'subject_ara',
}, {
title: 'Courses',
dataIndex: 'courses',
}, {
title: 'Operation',
dataIndex: 'operation',
}
]
};
},
mounted() {
},
methods: {
migrateTranscripts() {
if (this.klass.transcript_migrated == 1) {
if (!confirm('成積表分數已經轉換，是不確定重新轉換？')) {
return false;
}
} else {
if (!confirm('是否確定轉換成積表分數？')) {
return false;
}
}
this.$inertia.get(route("director.klass.transcript.migrate", this.klass.id), {
onSuccess: (page) => {
this.modal.isOpen = false;
console.log('Cancelled');
},
onError: (error) => {
console.log(error);
}
});
},
},
});
