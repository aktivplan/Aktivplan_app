## Super Admin

|                     Path                     |                  Widget                  | BeamerLocation                             |
| :------------------------------------------: | :--------------------------------------: | ------------------------------------------ |
|               '/institutions'                |        InstitutionOverviewPage()         | InstitutionsLocation()                     |
|             '/institutions/add'              |         ModifyInstitutionPage()          | InstitutionsAddLocation()                  |
|            '/institutions/:name'             |         ModifyInstitutionPage()          | InstitutionsEditLocation()                 |
|                                              |                                          |                                            |
|                  '/admins'                   |      InstitutionAdministratorPage()      | InstitutsAdminLocation()                   |
|                '/admins/add'                 |   ModifyInstitutionAdministratorPage()   | InstitutsAdminAddLocation()                |
|                '/admins/:id'                 |   ModifyInstitutionAdministratorPage()   | InstitutsAdminEditLocation()               |
|                                              |                                          |                                            |
|         '/healthcare-professionals'          | InstitutionHealthcareProfessionalsPage() | AdminHealthProfessionalsOverviewLocation() |
|       '/healthcare-professionals/add'        |      ModifyHealthProfessionalPage()      | AdminHPAddLocation()                       |
|       '/healthcare-professionals/:id'        |      ModifyHealthProfessionalPage()      | AdminHPEditLocation()                      |
|                                              |                                          |
|   '/healthcare-professionals/:id/patients'   |          PatientOverviewPage()           | AdminHPPatientLocation()                   |
| '/healthcare-professionals/:id/patients/add' |           ModifyPatientPage()            | AdminHPPatientLocation()                   |
| '/healthcare-professionals/:id/patients/:id' |           ModifyPatientPage()            | AdminHPPatientLocation()                   |



## Institution - Admin

|         Path         |             Widget             | BeamerLocation                        |
| :------------------: | :----------------------------: | ------------------------------------- |
|   '/professionals'   |   HealthProfessionalsPage()    | HealthcareProfessionalsLocation()     |
| '/professionals/add' | ModifyHealthProfessionalPage() | HealthcareProfessionalsAddLocation()  |
| '/professionals/:id' | ModifyHealthProfessionalPage() | HealthcareProfessionalsEditLocation() |
|                      |                                |



## Healthcare Professional

|                        Path                        |          Widget           | BeamerLocation                  |
| :------------------------------------------------: | :-----------------------: | ------------------------------- |
|                    '/patients'                     |   PatientOverviewPage()   | PatientsLocation()              |
|                  '/patients/add'                   |    ModifyPatientPage()    | PatientsAddLocation()           |
|                  '/patients/:id'                   |    ModifyPatientPage()    | PatientsEditLocation()          |
|                '/patients/:id/data'                |     PatientDataPage()     | PatientsDataLocation()          |
|             '/patients/:id/data/edit'              |    ModifyPatientPage()    | PatientsDataLocation()          |
|              '/patients/:id/calendar'              |   PatientCalendarPage()   | PatientsCalendarLocation()      |
|       '/patients/:id/calendar/goal-setting'        |     GoalSettingPage()     | PatientsGoalSettingLocation()   |
|       '/patients/:id/calendar/add-activity'        |   CreateActivityPage()    | PatientsActivityLocation()      |
| '/patients/:id/calendar/add-activity/workout/add'  |  EditWorkoutExerciseTypes()   | PatientsWorkoutAddLocation()    |
| '/patients/:id/calendar/add-activity/workout/edit' |  EditWorkoutExerciseTypes()   | PatientsWorkoutEditLocation()   |
|           '/patients/:id/active-minutes'           |    ActiveMinutesPage()    | PatientsActiveMinutesLocation() |
|            '/patients/:id/goal-setting'            |     GoalSettingPage()     | PatientsGoalSettingLocation()   |
|            '/patients/:id/export/:type'            | ExportDocumentationPage() | PatientsExportLocation()        |

## Institution - Admin & Healthcare Professional

|              Path               |         Widget          | BeamerLocation        |
| :-----------------------------: | :---------------------: | --------------------- |
|           '/training'           | ExerciseTypesOverviewPage() | TrainingsLocation()   |
|    '/training/:trainingType'    | ExerciseTypesOverviewPage() | TrainingsLocation()   |
|  '/training/:trainingType/add'  |  ModifyExerciseTypePage()   | TrainingsLocation()   |
| '/training/:trainingType/:name' |  ModifyExerciseTypePage()   | TrainingsLocation()   |
|                                 |                         |
|           '/workout'            |     WorkoutsPage()      | WorkoutLocation()     |
|         '/workout/add'          |   ModifyWorkoutPage()   | WorkoutAddLocation()  |
|         '/workout/:id'          |   ModifyWorkoutPage()   | WorkoutEditLocation() |

## Patients

|             Path             |             Widget              | BeamerLocation                   |
| :--------------------------: | :-----------------------------: | -------------------------------- |
|         '/calendar'          |      PatientCalendarPage()      | PatientHomeLocation()            |
|    '/add-extra-activity'     |       AddExtraActivity()        | ExtraActivityLocation()          |
|          '/export'           |    ExportDocumentationPage()    | ExportLocation()                 |
|          '/videos'           |      TrainingVideosPage()       | VideosLocation()                 |
|       '/calendar/data'       |        PatientDataPage()        | DataLocation()                   |
|    '/calendar/data/edit'     |       ModifyPatientPage()       | DataLocation()                   |
|         '/messages'          |         MessagesPage()          | MessagesLocation()               |
|      '/active-minutes'       |       ActiveMinutesPage()       | ActiveMinutesLocation()          |
| '/my-healtcare-professional' | HealthProfessionalProfilePage() | HealthcareProfessionalLocation() |
