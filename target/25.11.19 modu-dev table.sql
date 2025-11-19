USE [modu-db-dev]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_diagramobjects]    Script Date: 2025-11-19 오후 2:25:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE FUNCTION [dbo].[fn_diagramobjects]() 
	RETURNS int
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		declare @id_upgraddiagrams		int
		declare @id_sysdiagrams			int
		declare @id_helpdiagrams		int
		declare @id_helpdiagramdefinition	int
		declare @id_creatediagram	int
		declare @id_renamediagram	int
		declare @id_alterdiagram 	int 
		declare @id_dropdiagram		int
		declare @InstalledObjects	int

		select @InstalledObjects = 0

		select 	@id_upgraddiagrams = object_id(N'dbo.sp_upgraddiagrams'),
			@id_sysdiagrams = object_id(N'dbo.sysdiagrams'),
			@id_helpdiagrams = object_id(N'dbo.sp_helpdiagrams'),
			@id_helpdiagramdefinition = object_id(N'dbo.sp_helpdiagramdefinition'),
			@id_creatediagram = object_id(N'dbo.sp_creatediagram'),
			@id_renamediagram = object_id(N'dbo.sp_renamediagram'),
			@id_alterdiagram = object_id(N'dbo.sp_alterdiagram'), 
			@id_dropdiagram = object_id(N'dbo.sp_dropdiagram')

		if @id_upgraddiagrams is not null
			select @InstalledObjects = @InstalledObjects + 1
		if @id_sysdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 2
		if @id_helpdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 4
		if @id_helpdiagramdefinition is not null
			select @InstalledObjects = @InstalledObjects + 8
		if @id_creatediagram is not null
			select @InstalledObjects = @InstalledObjects + 16
		if @id_renamediagram is not null
			select @InstalledObjects = @InstalledObjects + 32
		if @id_alterdiagram  is not null
			select @InstalledObjects = @InstalledObjects + 64
		if @id_dropdiagram is not null
			select @InstalledObjects = @InstalledObjects + 128
		
		return @InstalledObjects 
	END
	
GO
/****** Object:  Table [dbo].[Interview2Question]    Script Date: 2025-11-19 오후 2:25:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Interview2Question](
	[QuestionId] [bigint] IDENTITY(1,1) NOT NULL,
	[QuestionNo] [bigint] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[ModifyDate] [datetime] NOT NULL,
	[Type] [nvarchar](20) NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
	[Difficulty] [smallint] NOT NULL,
	[Contents] [nvarchar](max) NOT NULL,
	[MemberId] [bigint] NOT NULL,
	[OwnerMemberId] [bigint] NOT NULL,
	[IsCommon] [bit] NOT NULL,
	[ChannelId] [bigint] NULL,
	[Tags] [nvarchar](200) NULL,
	[Category] [smallint] NULL,
	[References] [nvarchar](1024) NULL,
	[ViewCount] [int] NULL,
	[Verifier] [nvarchar](128) NULL,
	[VerifiedCode] [nvarchar](max) NULL,
	[VerifiedDate] [datetime] NULL,
	[VerifiedAnswer] [nvarchar](max) NULL,
	[VerifiedCount] [int] NULL,
	[InputExplanation] [nvarchar](1000) NULL,
	[OutputExplanation] [nvarchar](1000) NULL,
	[SubDomain] [nvarchar](50) NULL,
	[OnlyPractice] [bit] NULL,
	[LectureId] [bigint] NULL,
	[QuestionType] [smallint] NULL,
	[SeasonId] [bigint] NULL,
	[TestcaseGroups] [nvarchar](512) NULL,
	[Commentary] [nvarchar](2048) NULL,
	[Description] [nvarchar](max) NULL,
	[QuestionGroupId] [bigint] NULL,
	[IsDeleted] [bit] NULL,
	[subDescription] [nvarchar](2048) NULL,
	[QuestionSeqNo] [bigint] NULL,
	[ContentSystem] [varchar](20) NULL,
	[ContentType] [varchar](20) NULL,
	[Faq] [varchar](30) NULL,
 CONSTRAINT [PK_Interview2Question_QuestionId] PRIMARY KEY CLUSTERED 
(
	[QuestionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LmsInfo]    Script Date: 2025-11-19 오후 2:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LmsInfo](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[TextBookId] [varchar](100) NULL,
	[MainUnitId] [varchar](100) NULL,
	[MiddleUnitId] [varchar](100) NULL,
	[SmallUnitId] [varchar](100) NULL,
	[QuestionId] [bigint] NULL,
	[CreateDate] [datetime] NULL,
	[QuestionGroupId] [bigint] NULL,
	[TextBookName] [nvarchar](100) NULL,
	[MainUnitName] [nvarchar](100) NULL,
	[MiddleUnitName] [nvarchar](100) NULL,
	[SmallUnitName] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Interview2TestSubmitDetail]    Script Date: 2025-11-19 오후 2:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Interview2TestSubmitDetail](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[TestId] [bigint] NOT NULL,
	[QuestionId] [bigint] NOT NULL,
	[MemberId] [bigint] NOT NULL,
	[IsPassed] [bit] NULL,
	[CreateDate] [datetime] NOT NULL,
	[Language] [nvarchar](50) NULL,
	[Code] [ntext] NULL,
	[RawValue] [ntext] NULL,
	[AverageTime] [decimal](9, 3) NULL,
	[CodeLength] [bigint] NULL,
	[MemoryUsage] [bigint] NULL,
	[LectureId] [bigint] NULL,
	[LessonId] [bigint] NULL,
	[IsExam] [bit] NULL,
	[Score] [int] NULL,
	[IsEvaluate] [bit] NULL,
	[TryCount] [int] NULL,
	[GroupId] [varchar](50) NULL,
	[IsSubmitted] [bit] NOT NULL,
	[Comment] [nvarchar](500) NULL,
	[PracticeStatusId] [varchar](50) NULL,
	[TimeSpent] [time](7) NULL,
 CONSTRAINT [PK_Interview2TestSubmitDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member]    Script Date: 2025-11-19 오후 2:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member](
	[MemberId] [bigint] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](250) NOT NULL,
	[UserName] [nvarchar](100) NULL,
	[FamilyName] [nvarchar](50) NULL,
	[GivenName] [nvarchar](50) NULL,
	[ProfileUrl] [nvarchar](250) NULL,
	[PictureUrl] [nvarchar](250) NULL,
	[Gender] [nvarchar](10) NULL,
	[Locale] [nvarchar](10) NULL,
	[Provider] [nvarchar](10) NULL,
	[CreateDate] [datetime] NOT NULL,
	[ModifyDate] [datetime] NOT NULL,
	[Password] [nvarchar](100) NULL,
	[SocialId] [nvarchar](50) NULL,
	[Roles] [nvarchar](50) NOT NULL,
	[Token] [uniqueidentifier] NOT NULL,
	[IsActivated] [bit] NOT NULL,
	[Domain] [nvarchar](250) NOT NULL,
	[PhoneNumber] [nvarchar](50) NULL,
	[TimeZoneId] [nvarchar](50) NULL,
	[MembershipSite] [nvarchar](100) NULL,
	[NickName] [nvarchar](50) NULL,
	[Agreement] [bit] NOT NULL,
	[MarketingAgreement] [bit] NULL,
	[BornYear] [int] NULL,
	[LecturerProfile] [ntext] NULL,
	[InterestedAreas] [nvarchar](50) NULL,
	[StartPage] [smallint] NULL,
	[NotiEnabled] [smallint] NULL,
	[Point] [int] NULL,
	[Rank] [smallint] NULL,
	[DefaultChannelId] [bigint] NULL,
	[TotalPoint] [bigint] NULL,
	[MobileCertification] [bit] NULL,
	[ExternalLinkKey] [nvarchar](50) NULL,
	[GroupId] [bigint] NULL,
	[UserId] [nvarchar](100) NULL,
	[KerisUserId] [nvarchar](500) NULL,
 CONSTRAINT [PK_Member] PRIMARY KEY CLUSTERED 
(
	[MemberId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Member_Email] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_LmsResultBind]    Script Date: 2025-11-19 오후 2:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_LmsResultBind]
AS
SELECT TextBookId
	,MainUnitId
	,MiddleUnitId
	,SmallUnitId
	,KerisUserId
	,IsPassed
	,question.QuestionGroupId
	,question.QuestionId
	,submitdetail.CreateDate
	,TryCount
	,submitdetail.TimeSpent
	,submitDetail.MemberId
FROM Interview2Question question WITH (NOLOCK)
JOIN LmsInfo lms WITH (NOLOCK) ON question.QuestionGroupId = lms.QuestionGroupId
JOIN Interview2TestSubmitDetail submitdetail WITH (NOLOCK) ON question.QuestionId = submitdetail.QuestionId
JOIN Member member WITH (NOLOCK) ON submitdetail.MemberId = member.MemberId
WHERE IsDeleted = 0
GO
/****** Object:  Table [dbo].[QuestionGroup]    Script Date: 2025-11-19 오후 2:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuestionGroup](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[QuestionFolderId] [bigint] NOT NULL,
	[SubDomain] [nvarchar](20) NULL,
	[CreatedAt] [datetime2](7) NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsDeleted] [bit] NULL,
	[SeqNo] [bigint] NULL,
	[Type] [varchar](50) NULL,
	[IsQuestionBranch] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MemberRole]    Script Date: 2025-11-19 오후 2:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MemberRole](
	[RoleId] [bigint] IDENTITY(1,1) NOT NULL,
	[MemberId] [bigint] NOT NULL,
	[MemberRole] [int] NOT NULL,
	[ChannelId] [bigint] NULL,
	[IsApproved] [bit] NOT NULL,
 CONSTRAINT [PK_MemberRole] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_LmsTestBind]    Script Date: 2025-11-19 오후 2:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_LmsTestBind]
AS
WITH MinRoles AS (
    SELECT MemberId, MIN(MemberRole) AS MinRole
    FROM MemberRole WITH (NOLOCK)
    GROUP BY MemberId
)
SELECT 
    questionGroup.Id AS QuestionGroupId,
    question.Title,
    questionGroup.Name AS GroupName,
    question.QuestionId,
    lms.TextBookId,
    lms.MainUnitId,
    lms.MiddleUnitId,
    lms.SmallUnitId,
    lms.TextBookName,
    lms.MainUnitName,
    lms.MiddleUnitName,
    lms.SmallUnitName,
    questionGroup.CreatedAt,
    question.Type,
    question.ContentSystem,
    question.ContentType,
    question.MemberId,
    roles.MinRole AS Role
FROM 
    QuestionGroup questionGroup WITH (NOLOCK)
    JOIN LmsInfo lms WITH (NOLOCK) ON questionGroup.Id = lms.QuestionGroupId
    JOIN Interview2Question question WITH (NOLOCK) ON questionGroup.Id = question.QuestionGroupId
    JOIN MinRoles roles ON question.MemberId = roles.MemberId
WHERE 
    questionGroup.IsDeleted = 0 or question.IsDeleted = 0
GO
/****** Object:  Table [dbo].[PracticeStatus]    Script Date: 2025-11-19 오후 2:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PracticeStatus](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[QuestionGroupId] [bigint] NULL,
	[LectureCode] [varchar](50) NULL,
	[PracticeStartDate] [datetime] NULL,
	[PracticeEndDate] [datetime] NULL,
	[IsDeleted] [bit] NULL,
	[TeacherKerisId] [varchar](50) NULL,
	[IsGroup] [bit] NULL,
	[CurrentStatus] [varchar](50) NULL,
	[IsTeacherEvaluation] [bit] NULL,
	[CommonDbId] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_PracticeStatus]    Script Date: 2025-11-19 오후 2:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		
CREATE VIEW [dbo].[vw_PracticeStatus]
AS
(
		SELECT practiceStatus.Id
			,questionGroup.Id AS PracticeId
			,practiceStatus.LectureCode
			,lmsinfo.TextBookId
			,lmsinfo.MainUnitId
			,lmsinfo.MiddleUnitId
			,lmsInfo.SmallUnitId
			,lmsInfo.TextBookName
			,lmsInfo.MainUnitName
			,lmsInfo.MiddleUnitName
			,lmsInfo.SmallUnitName
			,questionGroup.Name AS Title
			,question.Type
			,question.QuestionId
			,Isnull(practiceStatus.IsGroup, CAST(0 AS BIT)) AS IsGroup
			,practiceStatus.PracticeStartDate
			,practiceStatus.PracticeEndDate
			,practiceStatus.CommonDbId as MNG_NO
			,practiceStatus.IsTeacherEvaluation
		FROM PracticeStatus practiceStatus WITH (NOLOCK)
		JOIN QuestionGroup questionGroup WITH (NOLOCK) ON practiceStatus.QuestionGroupId = questionGroup.Id
		JOIN LmsInfo lmsinfo WITH (NOLOCK) ON questionGroup.Id = lmsInfo.QuestionGroupId
		JOIN Interview2Question question WITH (NOLOCK) ON questionGroup.Id = question.QuestionGroupId
		)
GO
/****** Object:  View [dbo].[vw_StudentSubmitStatus]    Script Date: 2025-11-19 오후 2:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		
		
CREATE VIEW [dbo].[vw_StudentSubmitStatus]
AS
(
		SELECT submit.Id AS SubmitId
			,practiceStatus.CommonDbId AS PracticeStatusId
			,submit.IsPassed
			,submit.CreateDate
			,submit.TryCount
			,submit.TimeSpent
			,submit.QuestionId
			,question.QuestionGroupId
			,submit.RawValue
			,submit.Code
			,submit.IsEvaluate
			,submit.Score
			,submit.GroupId
			,submit.MemberId
			,ISNULL(practiceStatus.IsGroup, CAST(0 AS BIT)) AS IsGroup
			,practiceStatus.LectureCode
			,submit.IsSubmitted
			,submit.Comment
			,member.KerisUserId
		FROM Interview2TestSubmitDetail submit WITH (NOLOCK)
		JOIN PracticeStatus practiceStatus WITH (NOLOCK) ON submit.PracticeStatusId = practiceStatus.CommonDbId
		JOIN Interview2Question question WITH (NOLOCK) ON question.QuestionId = submit.QuestionId
		JOIN Member member WITH (NOLOCK) ON submit.MemberId = member.MemberId
		)
GO
/****** Object:  Table [dbo].[Chatting]    Script Date: 2025-11-19 오후 2:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chatting](
	[ChattingId] [bigint] IDENTITY(1,1) NOT NULL,
	[Content] [nvarchar](max) NULL,
	[QuestionGroupId] [bigint] NOT NULL,
	[TeacherMemberId] [bigint] NOT NULL,
	[StudentUserId] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[ChattingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClassInfo]    Script Date: 2025-11-19 오후 2:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClassInfo](
	[ClassId] [bigint] IDENTITY(1,1) NOT NULL,
	[LectureCode] [nvarchar](50) NOT NULL,
	[MemberId] [bigint] NOT NULL,
	[TeacherId] [bigint] NULL,
	[KerisUserId] [nvarchar](500) NOT NULL,
	[ClassCode] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[ClassId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Member] UNIQUE NONCLUSTERED 
(
	[ClassCode] ASC,
	[LectureCode] ASC,
	[MemberId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ConceptualLearning]    Script Date: 2025-11-19 오후 2:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConceptualLearning](
	[ConceptualLearningId] [bigint] IDENTITY(1,1) NOT NULL,
	[QuestionId] [bigint] NOT NULL,
	[Title] [nvarchar](100) NULL,
	[Content] [nvarchar](500) NULL,
	[Src] [nvarchar](500) NOT NULL,
	[Subtitle] [nvarchar](500) NULL,
	[DisplayOrder] [int] NULL,
	[CreatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ConceptualLearningId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Interview2QuestionBlankFilling]    Script Date: 2025-11-19 오후 2:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Interview2QuestionBlankFilling](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[QuestionId] [bigint] NOT NULL,
	[Index] [smallint] NOT NULL,
	[Key] [nvarchar](50) NOT NULL,
	[Placeholder] [nvarchar](200) NOT NULL,
	[Width] [smallint] NOT NULL,
	[Answer] [nvarchar](500) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Interview2QuestionCoding]    Script Date: 2025-11-19 오후 2:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Interview2QuestionCoding](
	[QuestionCodingId] [bigint] IDENTITY(1,1) NOT NULL,
	[QuestionId] [bigint] NOT NULL,
	[IsExample] [bit] NOT NULL,
	[Input] [ntext] NULL,
	[Output] [ntext] NULL,
	[UseExternalIde] [bit] NULL,
	[ProjectUrl] [nvarchar](2000) NULL,
	[IdeToolType] [nvarchar](20) NULL,
	[IndexSort] [smallint] NULL,
 CONSTRAINT [PK_Interview2QuestionCoding] PRIMARY KEY CLUSTERED 
(
	[QuestionCodingId] ASC,
	[QuestionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Interview2QuestionCommentary]    Script Date: 2025-11-19 오후 2:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Interview2QuestionCommentary](
	[QuestionCommentaryId] [bigint] IDENTITY(1,1) NOT NULL,
	[QuestionId] [bigint] NOT NULL,
	[Title] [nvarchar](200) NOT NULL,
	[Content] [nvarchar](500) NOT NULL,
	[Src] [nvarchar](500) NOT NULL,
	[Subtitle] [nvarchar](500) NULL,
	[SeqNo] [int] NOT NULL,
	[ImageContent] [nvarchar](500) NULL,
	[TextContent] [nvarchar](1000) NULL,
	[CommentaryType] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[QuestionId] ASC,
	[QuestionCommentaryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Interview2QuestionExampleCode]    Script Date: 2025-11-19 오후 2:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Interview2QuestionExampleCode](
	[QuestionExampleCodeId] [bigint] IDENTITY(1,1) NOT NULL,
	[QuestionId] [bigint] NOT NULL,
	[MemberId] [bigint] NOT NULL,
	[IsDefault] [bit] NOT NULL,
	[Language] [nvarchar](50) NOT NULL,
	[Code] [ntext] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[ModifyDate] [datetime] NULL,
 CONSTRAINT [PK_Interview2QuestionExampleCode] PRIMARY KEY CLUSTERED 
(
	[QuestionExampleCodeId] ASC,
	[QuestionId] ASC,
	[MemberId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Interview2QuestionLink]    Script Date: 2025-11-19 오후 2:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Interview2QuestionLink](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[QuestionId] [bigint] NOT NULL,
	[Name] [nvarchar](200) NULL,
	[Description] [nvarchar](500) NULL,
	[Url] [nvarchar](500) NOT NULL,
	[Type] [nvarchar](20) NOT NULL,
	[CreatedAt] [datetime2](7) NULL,
	[IsDeleted] [bit] NULL,
	[LinkIndex] [bigint] NULL,
	[EvaluationCode] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Interview2QuestionLink_temp]    Script Date: 2025-11-19 오후 2:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Interview2QuestionLink_temp](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[QuestionId] [bigint] NOT NULL,
	[Name] [nvarchar](200) NULL,
	[Description] [nvarchar](500) NULL,
	[Url] [nvarchar](500) NOT NULL,
	[Type] [nvarchar](20) NOT NULL,
	[CreatedAt] [datetime2](7) NULL,
	[IsDeleted] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Interview2QuestionMultiple]    Script Date: 2025-11-19 오후 2:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Interview2QuestionMultiple](
	[QuestionMultipleId] [bigint] IDENTITY(1,1) NOT NULL,
	[QuestionId] [bigint] NOT NULL,
	[Example] [nvarchar](100) NOT NULL,
	[IsAnswer] [bit] NOT NULL,
	[ExampleNo] [int] NOT NULL,
	[Commentary] [nvarchar](2048) NULL,
 CONSTRAINT [PK_Interview2QuestionMultiple] PRIMARY KEY CLUSTERED 
(
	[QuestionMultipleId] ASC,
	[QuestionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Interview2QuestionSelfCheck]    Script Date: 2025-11-19 오후 2:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Interview2QuestionSelfCheck](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[QuestionId] [bigint] NOT NULL,
	[Title] [nvarchar](200) NOT NULL,
	[Content] [nvarchar](500) NOT NULL,
	[CheckList] [nvarchar](2000) NOT NULL,
	[AnswerImage] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Interview2QuestionSelfCheckSubmit]    Script Date: 2025-11-19 오후 2:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Interview2QuestionSelfCheckSubmit](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[SelfCheckId] [bigint] NOT NULL,
	[SubmitImage] [nvarchar](2000) NULL,
	[SelfCheckListAnswerContent] [nvarchar](200) NULL,
	[SelfCheckListAnswerNumber] [int] NULL,
	[MemberId] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Interview2QuestionSubjective]    Script Date: 2025-11-19 오후 2:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Interview2QuestionSubjective](
	[QuestionSubjectiveId] [bigint] IDENTITY(1,1) NOT NULL,
	[QuestionId] [bigint] NOT NULL,
	[Answer] [nvarchar](1000) NULL,
	[Commentary] [nvarchar](2048) NULL,
 CONSTRAINT [PK_Interview2QuestionSubjective] PRIMARY KEY CLUSTERED 
(
	[QuestionSubjectiveId] ASC,
	[QuestionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Interview2TestEvaluationCoding]    Script Date: 2025-11-19 오후 2:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Interview2TestEvaluationCoding](
	[TestEvaluationCodingId] [bigint] IDENTITY(1,1) NOT NULL,
	[TestId] [bigint] NOT NULL,
	[QuestionId] [bigint] NOT NULL,
	[MemberId] [bigint] NOT NULL,
	[Code] [ntext] NOT NULL,
	[Language] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[AverageTime] [decimal](9, 3) NOT NULL,
	[CodeLength] [bigint] NULL,
	[MemoryUsage] [bigint] NULL,
	[LectureId] [bigint] NULL,
	[LessonId] [bigint] NULL,
	[IsExam] [bit] NULL,
 CONSTRAINT [PK_Interview2TestEvaluation] PRIMARY KEY CLUSTERED 
(
	[TestEvaluationCodingId] ASC,
	[TestId] ASC,
	[QuestionId] ASC,
	[MemberId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Interview2TestEvaluationCodingResult]    Script Date: 2025-11-19 오후 2:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Interview2TestEvaluationCodingResult](
	[TestEvaluationCodingId] [bigint] NOT NULL,
	[TestCaseIndex] [int] NOT NULL,
	[IsPassed] [bit] NOT NULL,
	[Time] [decimal](9, 3) NOT NULL,
 CONSTRAINT [PK_Interview2TestEvaluationResults] PRIMARY KEY CLUSTERED 
(
	[TestEvaluationCodingId] ASC,
	[TestCaseIndex] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Interview2TestSubmitOnlyCode]    Script Date: 2025-11-19 오후 2:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Interview2TestSubmitOnlyCode](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[TestId] [bigint] NOT NULL,
	[MemberId] [bigint] NOT NULL,
	[QuestionId] [bigint] NOT NULL,
	[Email] [nvarchar](200) NOT NULL,
	[Language] [nvarchar](50) NOT NULL,
	[Code] [ntext] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[ModifyDate] [datetime] NOT NULL,
	[LectureId] [bigint] NULL,
	[LessonId] [bigint] NULL,
	[IsExam] [bit] NULL,
 CONSTRAINT [PK_Interview2TestSubmitOnlyCode] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KnowledgeSystem]    Script Date: 2025-11-19 오후 2:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KnowledgeSystem](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[QuestionId] [bigint] NULL,
	[Depth1] [nvarchar](50) NULL,
	[Depth2] [nvarchar](50) NULL,
	[Depth3] [nvarchar](50) NULL,
	[CreatedAt] [datetime] NULL,
	[Depth1Nm] [nvarchar](100) NULL,
	[Depth2Nm] [nvarchar](100) NULL,
	[Depth3Nm] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuestionFolder]    Script Date: 2025-11-19 오후 2:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuestionFolder](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[SubDomain] [nvarchar](20) NULL,
	[CreatedAt] [datetime2](7) NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsDeleted] [bit] NULL,
	[SeqNo] [bigint] NULL,
	[Target] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SolveHistory]    Script Date: 2025-11-19 오후 2:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SolveHistory](
	[SolveHistoryId] [bigint] IDENTITY(1,1) NOT NULL,
	[Url] [nvarchar](500) NOT NULL,
	[Note] [nvarchar](500) NULL,
	[CreatedAt] [datetime] NULL,
	[IsDeleted] [bit] NULL,
	[QuestionId] [bigint] NULL,
	[MemberId] [bigint] NULL,
	[QuestionType] [nvarchar](50) NULL,
	[Score] [int] NULL,
	[QuestionGroupId] [bigint] NULL,
	[GroupId] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[SolveHistoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SolveStatus]    Script Date: 2025-11-19 오후 2:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SolveStatus](
	[StatusId] [bigint] NOT NULL,
	[DegreeOfInterest] [int] NULL,
	[DegreeOfUnderstanding] [int] NULL,
	[CreatedAt] [datetime] NULL,
	[IsDeleted] [bit] NULL,
	[QuestionId] [bigint] NULL,
	[MemberId] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[StatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudentPracticeStatus]    Script Date: 2025-11-19 오후 2:25:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentPracticeStatus](
	[PracticeStatusId] [bigint] NOT NULL,
	[MemberId] [bigint] NOT NULL,
	[QuestioinGroupId] [bigint] NOT NULL,
	[QuestionId] [bigint] NOT NULL,
	[PracticeDate] [datetime] NULL,
	[PracticeTime] [datetime] NULL,
	[PracticeStatus] [int] NOT NULL,
	[IsPracticeSubmission] [bit] NOT NULL,
	[IsPracticeGrade] [bit] NOT NULL,
	[IsPractice] [bit] NOT NULL,
	[SubmissionCount] [int] NULL,
	[PracticeScore] [int] NULL,
	[PracticeComment] [nvarchar](1000) NULL,
	[QuestionType] [nvarchar](50) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PracticeStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sysdiagrams]    Script Date: 2025-11-19 오후 2:25:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sysdiagrams](
	[name] [sysname] NOT NULL,
	[principal_id] [int] NOT NULL,
	[diagram_id] [int] IDENTITY(1,1) NOT NULL,
	[version] [int] NULL,
	[definition] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[diagram_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UK_principal_name] UNIQUE NONCLUSTERED 
(
	[principal_id] ASC,
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Interview2Question] ADD  CONSTRAINT [DF_Interview2Question_ViewCount]  DEFAULT ((0)) FOR [ViewCount]
GO
ALTER TABLE [dbo].[Interview2Question] ADD  DEFAULT ((0)) FOR [VerifiedCount]
GO
ALTER TABLE [dbo].[Interview2Question] ADD  DEFAULT (NULL) FOR [QuestionType]
GO
ALTER TABLE [dbo].[Interview2Question] ADD  DEFAULT (NULL) FOR [QuestionGroupId]
GO
ALTER TABLE [dbo].[Interview2Question] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Interview2Question] ADD  DEFAULT ((0)) FOR [QuestionSeqNo]
GO
ALTER TABLE [dbo].[Interview2QuestionCoding] ADD  DEFAULT ((0)) FOR [UseExternalIde]
GO
ALTER TABLE [dbo].[Interview2QuestionCommentary] ADD  DEFAULT (NULL) FOR [Subtitle]
GO
ALTER TABLE [dbo].[Interview2QuestionExampleCode] ADD  CONSTRAINT [DF_Interview2QuestionExampleCode_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[Interview2QuestionExampleCode] ADD  CONSTRAINT [DF_Interview2QuestionExampleCode_ModifyDate]  DEFAULT (getdate()) FOR [ModifyDate]
GO
ALTER TABLE [dbo].[Interview2QuestionLink] ADD  DEFAULT (NULL) FOR [Name]
GO
ALTER TABLE [dbo].[Interview2QuestionLink] ADD  DEFAULT (NULL) FOR [Description]
GO
ALTER TABLE [dbo].[Interview2QuestionLink] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Interview2QuestionLink] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Interview2QuestionLink] ADD  DEFAULT ((1)) FOR [LinkIndex]
GO
ALTER TABLE [dbo].[Interview2QuestionLink] ADD  DEFAULT (NULL) FOR [EvaluationCode]
GO
ALTER TABLE [dbo].[Interview2TestEvaluationCoding] ADD  CONSTRAINT [DF_Interview2TestEvaluationCoding_AverageTime]  DEFAULT ((0)) FOR [AverageTime]
GO
ALTER TABLE [dbo].[Interview2TestEvaluationCodingResult] ADD  CONSTRAINT [DF_Interview2TestEvaluationCodingResult_Time]  DEFAULT ((0)) FOR [Time]
GO
ALTER TABLE [dbo].[Interview2TestSubmitDetail] ADD  CONSTRAINT [DF_Interview2TestSubmitDetail_TestId]  DEFAULT ((0)) FOR [TestId]
GO
ALTER TABLE [dbo].[Interview2TestSubmitDetail] ADD  CONSTRAINT [DF_Interview2TestSubmitDetail_IsPassed]  DEFAULT (NULL) FOR [IsPassed]
GO
ALTER TABLE [dbo].[Interview2TestSubmitDetail] ADD  DEFAULT ((1)) FOR [IsSubmitted]
GO
ALTER TABLE [dbo].[Interview2TestSubmitDetail] ADD  CONSTRAINT [DF_Interview2TestSubmitDetail_Comment]  DEFAULT (NULL) FOR [Comment]
GO
ALTER TABLE [dbo].[Member] ADD  CONSTRAINT [DF_Member_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[Member] ADD  CONSTRAINT [DF_Member_ModifyDate]  DEFAULT (getdate()) FOR [ModifyDate]
GO
ALTER TABLE [dbo].[Member] ADD  CONSTRAINT [DF_Member_Roles]  DEFAULT ('user') FOR [Roles]
GO
ALTER TABLE [dbo].[Member] ADD  CONSTRAINT [DF_Member_Token]  DEFAULT (newid()) FOR [Token]
GO
ALTER TABLE [dbo].[Member] ADD  CONSTRAINT [DF_Member_IsActivated]  DEFAULT ((0)) FOR [IsActivated]
GO
ALTER TABLE [dbo].[Member] ADD  CONSTRAINT [DF_Member_Agreement]  DEFAULT ((1)) FOR [Agreement]
GO
ALTER TABLE [dbo].[Member] ADD  CONSTRAINT [DF_Member_NotiEnabled]  DEFAULT ((15)) FOR [NotiEnabled]
GO
ALTER TABLE [dbo].[Member] ADD  DEFAULT ((0)) FOR [Point]
GO
ALTER TABLE [dbo].[Member] ADD  DEFAULT ((1)) FOR [Rank]
GO
ALTER TABLE [dbo].[Member] ADD  DEFAULT ((0)) FOR [DefaultChannelId]
GO
ALTER TABLE [dbo].[Member] ADD  DEFAULT ((0)) FOR [TotalPoint]
GO
ALTER TABLE [dbo].[Member] ADD  DEFAULT ((0)) FOR [MobileCertification]
GO
ALTER TABLE [dbo].[MemberRole] ADD  CONSTRAINT [DF_MemberRole_ChannelId]  DEFAULT ((0)) FOR [ChannelId]
GO
ALTER TABLE [dbo].[MemberRole] ADD  CONSTRAINT [DF_MemberRole_IsApproved]  DEFAULT ((0)) FOR [IsApproved]
GO
ALTER TABLE [dbo].[QuestionFolder] ADD  DEFAULT (NULL) FOR [SubDomain]
GO
ALTER TABLE [dbo].[QuestionFolder] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[QuestionFolder] ADD  DEFAULT (getdate()) FOR [UpdatedAt]
GO
ALTER TABLE [dbo].[QuestionFolder] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[QuestionFolder] ADD  DEFAULT ((0)) FOR [SeqNo]
GO
ALTER TABLE [dbo].[QuestionGroup] ADD  DEFAULT (NULL) FOR [SubDomain]
GO
ALTER TABLE [dbo].[QuestionGroup] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[QuestionGroup] ADD  DEFAULT (getdate()) FOR [UpdatedAt]
GO
ALTER TABLE [dbo].[QuestionGroup] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[QuestionGroup] ADD  DEFAULT ((0)) FOR [SeqNo]
GO
ALTER TABLE [dbo].[StudentPracticeStatus] ADD  DEFAULT ((0)) FOR [PracticeStatus]
GO
ALTER TABLE [dbo].[StudentPracticeStatus] ADD  DEFAULT ((0)) FOR [IsPracticeSubmission]
GO
ALTER TABLE [dbo].[StudentPracticeStatus] ADD  DEFAULT ((0)) FOR [IsPracticeGrade]
GO
ALTER TABLE [dbo].[StudentPracticeStatus] ADD  DEFAULT ((0)) FOR [IsPractice]
GO
ALTER TABLE [dbo].[StudentPracticeStatus] ADD  DEFAULT (NULL) FOR [PracticeScore]
GO
ALTER TABLE [dbo].[StudentPracticeStatus] ADD  DEFAULT ('') FOR [PracticeComment]
GO
ALTER TABLE [dbo].[StudentPracticeStatus] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[ClassInfo]  WITH CHECK ADD FOREIGN KEY([MemberId])
REFERENCES [dbo].[Member] ([MemberId])
GO
ALTER TABLE [dbo].[ConceptualLearning]  WITH CHECK ADD FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Interview2Question] ([QuestionId])
GO
ALTER TABLE [dbo].[Interview2Question]  WITH CHECK ADD  CONSTRAINT [FK_Interview2Question_QuestionGroupId] FOREIGN KEY([QuestionGroupId])
REFERENCES [dbo].[QuestionGroup] ([Id])
GO
ALTER TABLE [dbo].[Interview2Question] CHECK CONSTRAINT [FK_Interview2Question_QuestionGroupId]
GO
ALTER TABLE [dbo].[Interview2QuestionBlankFilling]  WITH CHECK ADD  CONSTRAINT [FK_Interview2QuestionBlankFilling_QuestionId] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Interview2Question] ([QuestionId])
GO
ALTER TABLE [dbo].[Interview2QuestionBlankFilling] CHECK CONSTRAINT [FK_Interview2QuestionBlankFilling_QuestionId]
GO
ALTER TABLE [dbo].[Interview2QuestionLink]  WITH CHECK ADD  CONSTRAINT [FK_Interview2QuestionLink_QuestionId] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Interview2Question] ([QuestionId])
GO
ALTER TABLE [dbo].[Interview2QuestionLink] CHECK CONSTRAINT [FK_Interview2QuestionLink_QuestionId]
GO
ALTER TABLE [dbo].[Interview2QuestionSelfCheck]  WITH CHECK ADD  CONSTRAINT [FK_Interview2QuestionSelfCheck_QuestionId] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Interview2Question] ([QuestionId])
GO
ALTER TABLE [dbo].[Interview2QuestionSelfCheck] CHECK CONSTRAINT [FK_Interview2QuestionSelfCheck_QuestionId]
GO
ALTER TABLE [dbo].[Interview2QuestionSelfCheckSubmit]  WITH CHECK ADD  CONSTRAINT [fk_Member] FOREIGN KEY([MemberId])
REFERENCES [dbo].[Member] ([MemberId])
GO
ALTER TABLE [dbo].[Interview2QuestionSelfCheckSubmit] CHECK CONSTRAINT [fk_Member]
GO
ALTER TABLE [dbo].[Interview2QuestionSelfCheckSubmit]  WITH CHECK ADD  CONSTRAINT [fk_SelfCheck] FOREIGN KEY([SelfCheckId])
REFERENCES [dbo].[Interview2QuestionSelfCheck] ([Id])
GO
ALTER TABLE [dbo].[Interview2QuestionSelfCheckSubmit] CHECK CONSTRAINT [fk_SelfCheck]
GO
ALTER TABLE [dbo].[QuestionGroup]  WITH CHECK ADD  CONSTRAINT [FK_QuestionGroup_QuestionFolderId] FOREIGN KEY([QuestionFolderId])
REFERENCES [dbo].[QuestionFolder] ([Id])
GO
ALTER TABLE [dbo].[QuestionGroup] CHECK CONSTRAINT [FK_QuestionGroup_QuestionFolderId]
GO
ALTER TABLE [dbo].[SolveStatus]  WITH CHECK ADD FOREIGN KEY([MemberId])
REFERENCES [dbo].[Member] ([MemberId])
GO
ALTER TABLE [dbo].[SolveStatus]  WITH CHECK ADD FOREIGN KEY([MemberId])
REFERENCES [dbo].[Member] ([MemberId])
GO
ALTER TABLE [dbo].[SolveStatus]  WITH CHECK ADD FOREIGN KEY([MemberId])
REFERENCES [dbo].[Member] ([MemberId])
GO
ALTER TABLE [dbo].[SolveStatus]  WITH CHECK ADD FOREIGN KEY([MemberId])
REFERENCES [dbo].[Member] ([MemberId])
GO
ALTER TABLE [dbo].[SolveStatus]  WITH CHECK ADD FOREIGN KEY([MemberId])
REFERENCES [dbo].[Member] ([MemberId])
GO
ALTER TABLE [dbo].[SolveStatus]  WITH CHECK ADD FOREIGN KEY([MemberId])
REFERENCES [dbo].[Member] ([MemberId])
GO
ALTER TABLE [dbo].[SolveStatus]  WITH CHECK ADD FOREIGN KEY([MemberId])
REFERENCES [dbo].[Member] ([MemberId])
GO
ALTER TABLE [dbo].[SolveStatus]  WITH CHECK ADD FOREIGN KEY([MemberId])
REFERENCES [dbo].[Member] ([MemberId])
GO
ALTER TABLE [dbo].[SolveStatus]  WITH CHECK ADD FOREIGN KEY([MemberId])
REFERENCES [dbo].[Member] ([MemberId])
GO
ALTER TABLE [dbo].[SolveStatus]  WITH CHECK ADD FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Interview2Question] ([QuestionId])
GO
ALTER TABLE [dbo].[SolveStatus]  WITH CHECK ADD FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Interview2Question] ([QuestionId])
GO
ALTER TABLE [dbo].[SolveStatus]  WITH CHECK ADD FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Interview2Question] ([QuestionId])
GO
ALTER TABLE [dbo].[SolveStatus]  WITH CHECK ADD FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Interview2Question] ([QuestionId])
GO
ALTER TABLE [dbo].[SolveStatus]  WITH CHECK ADD FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Interview2Question] ([QuestionId])
GO
ALTER TABLE [dbo].[SolveStatus]  WITH CHECK ADD FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Interview2Question] ([QuestionId])
GO
ALTER TABLE [dbo].[SolveStatus]  WITH CHECK ADD FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Interview2Question] ([QuestionId])
GO
ALTER TABLE [dbo].[SolveStatus]  WITH CHECK ADD FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Interview2Question] ([QuestionId])
GO
ALTER TABLE [dbo].[SolveStatus]  WITH CHECK ADD FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Interview2Question] ([QuestionId])
GO
ALTER TABLE [dbo].[SolveStatus]  WITH CHECK ADD FOREIGN KEY([MemberId])
REFERENCES [dbo].[Member] ([MemberId])
GO
ALTER TABLE [dbo].[SolveStatus]  WITH CHECK ADD FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Interview2Question] ([QuestionId])
GO
/****** Object:  StoredProcedure [dbo].[sp_alterdiagram]    Script Date: 2025-11-19 오후 2:25:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_alterdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null,
		@version 	int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId 			int
		declare @retval 		int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @ShouldChangeUID	int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid ARG', 16, 1)
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();	 
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		revert;
	
		select @ShouldChangeUID = 0
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		
		if(@DiagId IS NULL or (@IsDbo = 0 and @theId <> @UIDFound))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end
	
		if(@IsDbo <> 0)
		begin
			if(@UIDFound is null or USER_NAME(@UIDFound) is null) -- invalid principal_id
			begin
				select @ShouldChangeUID = 1 ;
			end
		end

		-- update dds data			
		update dbo.sysdiagrams set definition = @definition where diagram_id = @DiagId ;

		-- change owner
		if(@ShouldChangeUID = 1)
			update dbo.sysdiagrams set principal_id = @theId where diagram_id = @DiagId ;

		-- update dds version
		if(@version is not null)
			update dbo.sysdiagrams set version = @version where diagram_id = @DiagId ;

		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[SP_CreateCodingTestLabAccount]    Script Date: 2025-11-19 오후 2:25:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      박세식
-- Create Date: 2019-12-12
-- Description: 코딩테스트랩 관리자 생성
-- 실행: Exec [SP_CreateCodingTestLabAccount] @email='codingtestadm@demo.com', @name=N'코딩테스트관리자', @labName=N'코딩테스트랩';
-- =============================================
CREATE PROCEDURE [dbo].[SP_CreateCodingTestLabAccount]
(
	@email nvarchar(100) = '',
	@name nvarchar(100) = '',
	@labName nvarchar(100) = ''
)
AS
BEGIN
    SET NOCOUNT ON
	
	Declare @NewMemberId bigint;
	Declare @ApplicationId bigint;
	Declare @ChannelId bigint;
	Declare @AdminMemberId bigint = 2074;
	Declare @DemoMemberId bigint = 3113;
	
    -- 데모 계정 생성하기 
	insert into member(email, locale, createdate, modifydate, password, roles, isactivated, domain, membershipsite, nickname, Agreement, startpage, NotiEnabled, DefaultChannelId)
	select @email as email, locale, createdate, modifydate, password, roles, isactivated, domain, membershipsite, @name as nickname, Agreement, startpage, NotiEnabled, DefaultChannelId
	from member
	where memberid=@DemoMemberId;
	
	-- 생성된 데모 계정 조회
	select @NewMemberId = memberid 
	from member
	where email= @email;

	-- MemberRole 수강생롤 추가하기
	insert into memberrole(memberid, Memberrole, ChannelId, IsApproved)
	values(@NewMemberId, 4, 0, 1);


	/****** 관리자용 쿼리 시작 ******/
	-- 채널 신청하기	
	insert into LecturerApplication(MemberId, RealName, mobile, Company, career, ServicePolicyAgreedDate, state, CreateDate, ModifyDate, ChannelName, ChannelDescription, ChannelRoadmap, ChannelType, ApplicationType)
	values(@NewMemberId, @name, '01000000000', N'멘토릿', N'멘토릿', getdate(), 3, getdate(), getdate(), @labName, N'코딩 테스트 랩', N'코딩테스트', 2, 2);

	-- 채널 신청된 applicationId 조회
	select @ApplicationId = id from LecturerApplication
	where memberid=@NewMemberId;

	-- 채널 승인하기
	insert into channel(memberid, ApplicationId, CreateDate, Type, State, IsCodingTestLab)
	values(@NewMemberId, @ApplicationId, getdate(), 1, 1, 1);

	-- 승인된 채널 아이디 조회
	select @ChannelId = Id from channel
	where memberid=@NewMemberId;

	-- 채널요청자료 업데이트하기
	update LecturerApplication
	set ChannelId = @ChannelId
	where id=@ApplicationId;

	-- MemberRole 코딩랩관리자롤 추가하기
	insert into memberrole(memberid, Memberrole, ChannelId, IsApproved)
	values(@NewMemberId, 9, @ChannelId, 1);

END
GO
/****** Object:  StoredProcedure [dbo].[SP_CreateDemoAccount]    Script Date: 2025-11-19 오후 2:25:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      박세식
-- Create Date: 2019-06-03
-- Description: 데모 계정 생성
-- =============================================
CREATE PROCEDURE [dbo].[SP_CreateDemoAccount]
(
	@email nvarchar(100) = '',
	@name nvarchar(100) = '',
	@labName nvarchar(100) = '',
	@lectureId1 bigint = 0,
	@lectureId2 bigint = 0,
	@lectureId3 bigint = 0
)
AS
BEGIN
    SET NOCOUNT ON

	Declare @NewMemberId bigint;
	Declare @ApplicationId bigint;
	Declare @ChannelId bigint;
	Declare @AdminMemberId bigint = 2074;
	Declare @DemoMemberId bigint = 3113;

    -- 데모 계정 생성하기 
	insert into member(email, locale, createdate, modifydate, password, roles, isactivated, domain, membershipsite, nickname, Agreement, startpage, NotiEnabled, DefaultChannelId)
	select @email as email, locale, createdate, modifydate, password, roles, isactivated, domain, membershipsite, @name as nickname, Agreement, startpage, NotiEnabled, DefaultChannelId
	from member
	where memberid=@DemoMemberId;
	
	-- 생성된 데모 계정 조회
	select @NewMemberId = memberid 
	from member
	where email= @email;

	-- MemberRole 수강생롤 추가하기
	insert into memberrole(memberid, Memberrole, ChannelId, IsApproved)
	values(@NewMemberId, 4, 0, 1);

	-- 채널 신청하기
	insert into LecturerApplication(MemberId, RealName, mobile, Company, career, ServicePolicyAgreedDate, state, CreateDate, ModifyDate, ChannelName, ChannelDescription, ChannelRoadmap, ChannelType, ApplicationType)
	values(@NewMemberId, @name, '01000000000', N'(주)멘토릿', N'멘토릿 데모 관리자', getdate(), 3, getdate(), getdate(), @labName, N'모두의코딩 교육 체험', N'체험', 2, 2);

	-- 채널 신청된 applicationId 조회
	select @ApplicationId = id from LecturerApplication
	where memberid=@NewMemberId;

	-- 채널 승인하기
	insert into channel(memberid, ApplicationId, CreateDate, Type, State)
	values(@NewMemberId, @ApplicationId, getdate(), 1, 1);

	-- 승인된 채널 아이디 조회
	select @ChannelId = Id from channel
	where memberid=@NewMemberId;

	-- 채널요청자료 업데이트하기
	update LecturerApplication
	set ChannelId = @ChannelId
	where id=@ApplicationId;

	-- MemberRole 코딩랩관리자롤 추가하기
	insert into memberrole(memberid, Memberrole, ChannelId, IsApproved)
	values(@NewMemberId, 1, @ChannelId, 1);

	-- 복제된 강좌를 데모 계정에 옮기기
	update modulecture
	set memberid=@NewMemberId, 
		OwnerMemberId=@AdminMemberId, 
		Lecturers=concat(@AdminMemberId,', ', @NewMemberId), 
		channelid=@ChannelId
	where lectureid in (@lectureId1, @lectureId2, @lectureId3);

	-- 복제된 강좌 수강신청하기
	-- 마지막에 만들어진 스크래치 강좌부터 인서트하기
	-- 스크래치 > 딥러닝 > 파이썬3
	-- 데모 시나리오 문서와 동일하게 표현하기 위함
	insert into modulecturestudent(lectureid, memberid, IsApproved, CreateDate, ModifyDate, State)
	values(@lectureId3, @NewMemberId, 1, getdate(), getdate(), 1);
	insert into modulecturestudent(lectureid, memberid, IsApproved, CreateDate, ModifyDate, State)
	values(@lectureId2, @NewMemberId, 1, getdate(), getdate(), 1);
	insert into modulecturestudent(lectureid, memberid, IsApproved, CreateDate, ModifyDate, State)
	values(@lectureId1, @NewMemberId, 1, getdate(), getdate(), 1);
END
GO
/****** Object:  StoredProcedure [dbo].[sp_creatediagram]    Script Date: 2025-11-19 오후 2:25:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_creatediagram]
	(
		@diagramname 	sysname,
		@owner_id		int	= null, 	
		@version 		int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId int
		declare @retval int
		declare @IsDbo	int
		declare @userName sysname
		if(@version is null or @diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID(); 
		select @IsDbo = IS_MEMBER(N'db_owner');
		revert; 
		
		if @owner_id is null
		begin
			select @owner_id = @theId;
		end
		else
		begin
			if @theId <> @owner_id
			begin
				if @IsDbo = 0
				begin
					RAISERROR (N'E_INVALIDARG', 16, 1);
					return -1
				end
				select @theId = @owner_id
			end
		end
		-- next 2 line only for test, will be removed after define name unique
		if EXISTS(select diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @diagramname)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end
	
		insert into dbo.sysdiagrams(name, principal_id , version, definition)
				VALUES(@diagramname, @theId, @version, @definition) ;
		
		select @retval = @@IDENTITY 
		return @retval
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_dropdiagram]    Script Date: 2025-11-19 오후 2:25:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_dropdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT; 
		
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		delete from dbo.sysdiagrams where diagram_id = @DiagId;
	
		return 0;
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_helpdiagramdefinition]    Script Date: 2025-11-19 오후 2:25:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_helpdiagramdefinition]
	(
		@diagramname 	sysname,
		@owner_id	int	= null 		
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		set nocount on

		declare @theId 		int
		declare @IsDbo 		int
		declare @DiagId		int
		declare @UIDFound	int
	
		if(@diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner');
		if(@owner_id is null)
			select @owner_id = @theId;
		revert; 
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname;
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId ))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end

		select version, definition FROM dbo.sysdiagrams where diagram_id = @DiagId ; 
		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_helpdiagrams]    Script Date: 2025-11-19 오후 2:25:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_helpdiagrams]
	(
		@diagramname sysname = NULL,
		@owner_id int = NULL
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		DECLARE @user sysname
		DECLARE @dboLogin bit
		EXECUTE AS CALLER;
			SET @user = USER_NAME();
			SET @dboLogin = CONVERT(bit,IS_MEMBER('db_owner'));
		REVERT;
		SELECT
			[Database] = DB_NAME(),
			[Name] = name,
			[ID] = diagram_id,
			[Owner] = USER_NAME(principal_id),
			[OwnerID] = principal_id
		FROM
			sysdiagrams
		WHERE
			(@dboLogin = 1 OR USER_NAME(principal_id) = @user) AND
			(@diagramname IS NULL OR name = @diagramname) AND
			(@owner_id IS NULL OR principal_id = @owner_id)
		ORDER BY
			4, 5, 1
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_renamediagram]    Script Date: 2025-11-19 오후 2:25:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_renamediagram]
	(
		@diagramname 		sysname,
		@owner_id		int	= null,
		@new_diagramname	sysname
	
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @DiagIdTarg		int
		declare @u_name			sysname
		if((@diagramname is null) or (@new_diagramname is null))
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT;
	
		select @u_name = USER_NAME(@owner_id)
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		-- if((@u_name is not null) and (@new_diagramname = @diagramname))	-- nothing will change
		--	return 0;
	
		if(@u_name is null)
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @new_diagramname
		else
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @owner_id and name = @new_diagramname
	
		if((@DiagIdTarg is not null) and  @DiagId <> @DiagIdTarg)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end		
	
		if(@u_name is null)
			update dbo.sysdiagrams set [name] = @new_diagramname, principal_id = @theId where diagram_id = @DiagId
		else
			update dbo.sysdiagrams set [name] = @new_diagramname where diagram_id = @DiagId
		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_upgraddiagrams]    Script Date: 2025-11-19 오후 2:25:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_upgraddiagrams]
	AS
	BEGIN
		IF OBJECT_ID(N'dbo.sysdiagrams') IS NOT NULL
			return 0;
	
		CREATE TABLE dbo.sysdiagrams
		(
			name sysname NOT NULL,
			principal_id int NOT NULL,	-- we may change it to varbinary(85)
			diagram_id int PRIMARY KEY IDENTITY,
			version int,
	
			definition varbinary(max)
			CONSTRAINT UK_principal_name UNIQUE
			(
				principal_id,
				name
			)
		);


		/* Add this if we need to have some form of extended properties for diagrams */
		/*
		IF OBJECT_ID(N'dbo.sysdiagram_properties') IS NULL
		BEGIN
			CREATE TABLE dbo.sysdiagram_properties
			(
				diagram_id int,
				name sysname,
				value varbinary(max) NOT NULL
			)
		END
		*/

		IF OBJECT_ID(N'dbo.dtproperties') IS NOT NULL
		begin
			insert into dbo.sysdiagrams
			(
				[name],
				[principal_id],
				[version],
				[definition]
			)
			select	 
				convert(sysname, dgnm.[uvalue]),
				DATABASE_PRINCIPAL_ID(N'dbo'),			-- will change to the sid of sa
				0,							-- zero for old format, dgdef.[version],
				dgdef.[lvalue]
			from dbo.[dtproperties] dgnm
				inner join dbo.[dtproperties] dggd on dggd.[property] = 'DtgSchemaGUID' and dggd.[objectid] = dgnm.[objectid]	
				inner join dbo.[dtproperties] dgdef on dgdef.[property] = 'DtgSchemaDATA' and dgdef.[objectid] = dgnm.[objectid]
				
			where dgnm.[property] = 'DtgSchemaNAME' and dggd.[uvalue] like N'_EA3E6268-D998-11CE-9454-00AA00A3F36E_' 
			return 2;
		end
		return 1;
	END
	
GO
EXEC sys.sp_addextendedproperty @name=N'microsoft_database_tools_support', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sysdiagrams'
GO
