import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { CourseManagementComponent } from '../app/components/course-management/course-management.component'; // Assurez-vous que le chemin est correct

const routes: Routes = [
  { path: 'courses', component: CourseManagementComponent }, // Vérifiez que le chemin est correct
  // Ajoutez d'autres routes ici si nécessaire
  { path: '', redirectTo: '/courses', pathMatch: 'full' }, // Redirige vers '/courses' si la route est vide
  { path: '**', redirectTo: '/courses' } // Redirection pour les routes non définies
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
