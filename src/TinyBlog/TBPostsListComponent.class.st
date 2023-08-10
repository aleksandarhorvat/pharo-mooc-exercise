Class {
	#name : #TBPostsListComponent,
	#superclass : #TBScreenComponent,
	#instVars : [
		'postComponents',
		'currentCategory',
		'showLoginError'
	],
	#category : #'TinyBlog-Components'
}

{ #category : #rendering }
TBPostsListComponent >> basicRenderCategoriesOn: html [
	html render: self categoriesComponent
]

{ #category : #rendering }
TBPostsListComponent >> basicRenderPostsOn: html [
	self readSelectedPosts do: [ :p | html render: (self postComponentFor: p) ]
]

{ #category : #'component creation' }
TBPostsListComponent >> categoriesComponent [
	^ TBCategoriesComponent
	categories: self blog allCategories
	postsList: self
]

{ #category : #hooks }
TBPostsListComponent >> children [
	^ self postComponents, super children
]

{ #category : #accessing }
TBPostsListComponent >> currentCategory [
	^ currentCategory
]

{ #category : #accessing }
TBPostsListComponent >> currentCategory: anObject [
	currentCategory := anObject
]

{ #category : #action }
TBPostsListComponent >> goToAdministrationView [
	self call: TBAdminComponent new
]

{ #category : #accessing }
TBPostsListComponent >> hasLoginError [
	^ showLoginError ifNil: [ false ]
]

{ #category : #initialization }
TBPostsListComponent >> initialize [
	super initialize.
	postComponents := OrderedCollection new
]

{ #category : #accessing }
TBPostsListComponent >> loginErrorMessage [
	^ 'Incorrect login and/or password'
]

{ #category : #accessing }
TBPostsListComponent >> loginErrorOccurred [
	showLoginError := true
]

{ #category : #'component creation' }
TBPostsListComponent >> postComponentFor: aPost [
	^ TBPostComponent new post: aPost
]

{ #category : #accessing }
TBPostsListComponent >> postComponents [
	postComponents := self readSelectedPosts
	collect: [ :each | TBPostComponent new post: each ].
	^ postComponents
]

{ #category : #accessing }
TBPostsListComponent >> readSelectedPosts [
	^ self currentCategory
	ifNil: [ self blog allVisibleBlogPosts ]
	ifNotNil: [ self blog allVisibleBlogPostsFromCategory: self currentCategory ]
]

{ #category : #rendering }
TBPostsListComponent >> renderCategoryColumnOn: html [
	html tbsColumn
		extraSmallSize: 12;
		smallSize: 2;
		mediumSize: 4;
	with: [ self basicRenderCategoriesOn: html ]
]

{ #category : #rendering }
TBPostsListComponent >> renderContentOn: html [
	super renderContentOn: html.
	html
		tbsContainer: [
			html tbsRow
			showGrid;
			with: [ self renderCategoryColumnOn: html.
				self renderPostColumnOn: html ] ]
]

{ #category : #rendering }
TBPostsListComponent >> renderLoginErrorMessageIfAnyOn: html [
	self hasLoginError ifTrue: [
		showLoginError := false.
		html tbsAlert
			beDanger ;
			with: self loginErrorMessage
	]
]

{ #category : #rendering }
TBPostsListComponent >> renderPostColumnOn: html [
	html tbsColumn
		extraSmallSize: 12;
		smallSize: 10;
		mediumSize: 8;
		with: [
			self renderLoginErrorMessageIfAnyOn: html.
			self basicRenderPostsOn: html ]
]

{ #category : #callbacks }
TBPostsListComponent >> tryConnectionWithLogin: login andPassword: password [
	(login = self blog administrator login and: [
		(SHA256 hashMessage: password) = self blog administrator
		password ])
			ifTrue: [
				self session currentAdmin: self blog administrator.
				self goToAdministrationView ]
			ifFalse: [ self loginErrorOccurred ]
]
