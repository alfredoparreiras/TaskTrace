# TaskTrace
##### Author: Alfredo Silva

## Initial Screen 
### Layout
- Users have options to either Log In or Sign Up. 
- Provide a Forgot Password Feature for uses who need to recover their accounts. 


## User
### New Account
- Users are permitted one account per email address.
- Verification of data before saving user. 
- Users can upload a profile image.
- If the account creation is successful, save the user and send a confirmation email.
- Users are redirected to the Initial Page for logging in.

### Delete Account
- Users can delete their accounts.
- Upon account deletion, all associated tasks will be deleted.
- Display a message reiterating that the deleted data **CANNOT BE** recovered.

### Login
- Users' login credentials are verified, incorrect attempts are handled appropriately.

### Account Setting
- Users can update their profile information and password.
- 
## Task 
### New Task
- Each task receives a unique ID.
- Task Fields
  - Name
  - Priority
  - Due Date
  - Created At (automatically populated when the task is created)
  - Description
  - Category
  - Project
  - Done (completion status)
  
- Validate input for all task fields.

### Task Listing
- Provide filter and search feature 
- Use pagination for task listing if the list becomes to long

### Delete Task 
- Tasks can be deleted (such action CANNOT be undone). If time permits, consider allowing some time for task recovery.
- Provide the option to reorder tasks based on priority, due date, etc.

### Update Task 
- Tasks can be updated. 

## Reports
- Generate reports by Due Date.
- Generate reports by Priority.
- Generate reports by Project.
- Generate reports by Category.
- Reports come with date filter options such as for this week, this month, and this year.