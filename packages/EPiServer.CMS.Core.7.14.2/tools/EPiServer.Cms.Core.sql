-- EPiServer.Cms.Core database script--


GO
PRINT N'Creating [dbo].[UriPartsTable]...';


GO
CREATE TYPE [dbo].[UriPartsTable] AS TABLE (
    [Host] NVARCHAR (255)  NOT NULL,
    [Path] NVARCHAR (2048) NOT NULL);


GO
PRINT N'Creating [dbo].[ContentReferenceTable]...';


GO
CREATE TYPE [dbo].[ContentReferenceTable] AS TABLE (
    [ID]       INT            NULL,
    [WorkID]   INT            NULL,
    [Provider] NVARCHAR (255) NULL);


GO
PRINT N'Creating [dbo].[IDTable]...';


GO
CREATE TYPE [dbo].[IDTable] AS TABLE (
    [ID] INT NOT NULL);


GO
PRINT N'Creating [dbo].[ProjectItemTable]...';


GO
CREATE TYPE [dbo].[ProjectItemTable] AS TABLE (
    [ID]                  INT            NULL,
    [ProjectID]           INT            NULL,
    [ContentLinkID]       INT            NULL,
    [ContentLinkWorkID]   INT            NULL,
    [ContentLinkProvider] NVARCHAR (255) NULL,
    [Language]            NVARCHAR (17)  NULL,
    [Category]            NVARCHAR (255) NULL);


GO
PRINT N'Creating [dbo].[ProjectMemberTable]...';


GO
CREATE TYPE [dbo].[ProjectMemberTable] AS TABLE (
    [ID]   INT           NULL,
    [Name] VARCHAR (255) NULL,
    [Type] SMALLINT      NULL);


GO
PRINT N'Creating [dbo].[ChangeNotificationStringTable]...';


GO
CREATE TYPE [dbo].[ChangeNotificationStringTable] AS TABLE (
    [Value] NVARCHAR (450) COLLATE Latin1_General_BIN2 NULL);


GO
PRINT N'Creating [dbo].[ChangeNotificationIntTable]...';


GO
CREATE TYPE [dbo].[ChangeNotificationIntTable] AS TABLE (
    [Value] INT NULL);


GO
PRINT N'Creating [dbo].[ChangeNotificationGuidTable]...';


GO
CREATE TYPE [dbo].[ChangeNotificationGuidTable] AS TABLE (
    [Value] UNIQUEIDENTIFIER NULL);


GO
PRINT N'Creating [dbo].[GuidParameterTable]...';


GO
CREATE TYPE [dbo].[GuidParameterTable] AS TABLE (
    [Id] UNIQUEIDENTIFIER NULL);


GO
PRINT N'Creating [dbo].[tblMappedIdentity]...';


GO
CREATE TABLE [dbo].[tblMappedIdentity] (
    [pkID]                   INT              IDENTITY (1, 1) NOT NULL,
    [Provider]               NVARCHAR (255)   NOT NULL,
    [ProviderUniqueId]       NVARCHAR (2048)  NOT NULL,
    [ContentGuid]            UNIQUEIDENTIFIER NOT NULL,
    [ExistingContentId]      INT              NULL,
    [ExistingCustomProvider] BIT              NULL,
    CONSTRAINT [PK_tblMappedIdentity] PRIMARY KEY NONCLUSTERED ([pkID] ASC)
);


GO
PRINT N'Creating [dbo].[tblMappedIdentity].[IDX_tblMappedIdentity_Provider]...';


GO
CREATE CLUSTERED INDEX [IDX_tblMappedIdentity_Provider]
    ON [dbo].[tblMappedIdentity]([Provider] ASC, [ProviderUniqueId] ASC);


GO
PRINT N'Creating [dbo].[tblMappedIdentity].[IDX_tblMappedIdentity_ContentGuid]...';


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_tblMappedIdentity_ContentGuid]
    ON [dbo].[tblMappedIdentity]([ContentGuid] ASC);


GO
PRINT N'Creating [dbo].[tblMappedIdentity].[IDX_tblMappedIdentity_ExternalId]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblMappedIdentity_ExternalId]
    ON [dbo].[tblMappedIdentity]([ExistingContentId] ASC, [ExistingCustomProvider] ASC);


GO
PRINT N'Creating [dbo].[tblProjectMember]...';


GO
CREATE TABLE [dbo].[tblProjectMember] (
    [pkID]        INT            IDENTITY (1, 1) NOT NULL,
    [fkProjectID] INT            NOT NULL,
    [Name]        NVARCHAR (255) NOT NULL,
    [Type]        SMALLINT       NOT NULL,
    CONSTRAINT [PK_tblProjectMember] PRIMARY KEY CLUSTERED ([pkID] ASC)
);


GO
PRINT N'Creating [dbo].[tblProjectMember].[IX_tblProjectMember_fkProjectID]...';


GO
CREATE NONCLUSTERED INDEX [IX_tblProjectMember_fkProjectID]
    ON [dbo].[tblProjectMember]([fkProjectID] ASC);


GO
PRINT N'Creating [dbo].[tblProjectItem]...';


GO
CREATE TABLE [dbo].[tblProjectItem] (
    [pkID]                INT            IDENTITY (1, 1) NOT NULL,
    [fkProjectID]         INT            NOT NULL,
    [ContentLinkID]       INT            NOT NULL,
    [ContentLinkWorkID]   INT            NOT NULL,
    [ContentLinkProvider] NVARCHAR (255) NOT NULL,
    [Language]            VARCHAR (17)   NOT NULL,
    [Category]            NVARCHAR (255) NOT NULL,
    CONSTRAINT [PK_tblProjectItem] PRIMARY KEY CLUSTERED ([pkID] ASC)
);


GO
PRINT N'Creating [dbo].[tblProjectItem].[IX_tblProjectItem_ContentLink]...';


GO
CREATE NONCLUSTERED INDEX [IX_tblProjectItem_ContentLink]
    ON [dbo].[tblProjectItem]([ContentLinkID] ASC, [ContentLinkProvider] ASC, [ContentLinkWorkID] ASC);


GO
PRINT N'Creating [dbo].[tblProjectItem].[IX_tblProjectItem_fkProjectID]...';


GO
CREATE NONCLUSTERED INDEX [IX_tblProjectItem_fkProjectID]
    ON [dbo].[tblProjectItem]([fkProjectID] ASC, [Category] ASC, [Language] ASC);


GO
PRINT N'Creating [dbo].[tblProject]...';


GO
CREATE TABLE [dbo].[tblProject] (
    [pkID]                    INT            IDENTITY (1, 1) NOT NULL,
    [Name]                    NVARCHAR (255) NOT NULL,
    [IsPublic]                BIT            NOT NULL,
    [Created]                 DATETIME       NOT NULL,
    [CreatedBy]               NVARCHAR (255) NOT NULL,
    [Status]                  INT            NOT NULL,
    [PublishingTrackingToken] NVARCHAR (255) NULL,
    [DelayPublishUntil]       DATETIME       NULL,
    CONSTRAINT [PK_tblProject] PRIMARY KEY CLUSTERED ([pkID] ASC)
);


GO
PRINT N'Creating [dbo].[tblProject].[IX_tblProject_StatusName]...';


GO
CREATE NONCLUSTERED INDEX [IX_tblProject_StatusName]
    ON [dbo].[tblProject]([Status] ASC, [Name] ASC);


GO
PRINT N'Creating [dbo].[tblVisitorGroupStatistic]...';


GO
CREATE TABLE [dbo].[tblVisitorGroupStatistic] (
    [pkId]               BIGINT           NOT NULL,
    [Row]                INT              NOT NULL,
    [StoreName]          NVARCHAR (375)   NOT NULL,
    [ItemType]           NVARCHAR (2000)  NOT NULL,
    [Boolean01]          BIT              NULL,
    [Boolean02]          BIT              NULL,
    [Boolean03]          BIT              NULL,
    [Boolean04]          BIT              NULL,
    [Boolean05]          BIT              NULL,
    [Integer01]          INT              NULL,
    [Integer02]          INT              NULL,
    [Integer03]          INT              NULL,
    [Integer04]          INT              NULL,
    [Integer05]          INT              NULL,
    [Integer06]          INT              NULL,
    [Integer07]          INT              NULL,
    [Integer08]          INT              NULL,
    [Integer09]          INT              NULL,
    [Integer10]          INT              NULL,
    [Long01]             BIGINT           NULL,
    [Long02]             BIGINT           NULL,
    [Long03]             BIGINT           NULL,
    [Long04]             BIGINT           NULL,
    [Long05]             BIGINT           NULL,
    [DateTime01]         DATETIME         NULL,
    [DateTime02]         DATETIME         NULL,
    [DateTime03]         DATETIME         NULL,
    [DateTime04]         DATETIME         NULL,
    [DateTime05]         DATETIME         NULL,
    [Guid01]             UNIQUEIDENTIFIER NULL,
    [Guid02]             UNIQUEIDENTIFIER NULL,
    [Guid03]             UNIQUEIDENTIFIER NULL,
    [Float01]            FLOAT (53)       NULL,
    [Float02]            FLOAT (53)       NULL,
    [Float03]            FLOAT (53)       NULL,
    [Float04]            FLOAT (53)       NULL,
    [Float05]            FLOAT (53)       NULL,
    [Float06]            FLOAT (53)       NULL,
    [Float07]            FLOAT (53)       NULL,
    [String01]           NVARCHAR (MAX)   NULL,
    [String02]           NVARCHAR (MAX)   NULL,
    [String03]           NVARCHAR (MAX)   NULL,
    [String04]           NVARCHAR (MAX)   NULL,
    [String05]           NVARCHAR (MAX)   NULL,
    [String06]           NVARCHAR (MAX)   NULL,
    [String07]           NVARCHAR (MAX)   NULL,
    [String08]           NVARCHAR (MAX)   NULL,
    [String09]           NVARCHAR (MAX)   NULL,
    [String10]           NVARCHAR (MAX)   NULL,
    [Binary01]           VARBINARY (MAX)  NULL,
    [Binary02]           VARBINARY (MAX)  NULL,
    [Binary03]           VARBINARY (MAX)  NULL,
    [Binary04]           VARBINARY (MAX)  NULL,
    [Binary05]           VARBINARY (MAX)  NULL,
    [Indexed_Boolean01]  BIT              NULL,
    [Indexed_Integer01]  INT              NULL,
    [Indexed_Integer02]  INT              NULL,
    [Indexed_Integer03]  INT              NULL,
    [Indexed_Long01]     BIGINT           NULL,
    [Indexed_Long02]     BIGINT           NULL,
    [Indexed_DateTime01] DATETIME         NULL,
    [Indexed_Guid01]     UNIQUEIDENTIFIER NULL,
    [Indexed_Float01]    FLOAT (53)       NULL,
    [Indexed_Float02]    FLOAT (53)       NULL,
    [Indexed_Float03]    FLOAT (53)       NULL,
    [Indexed_String01]   NVARCHAR (450)   NULL,
    [Indexed_String02]   NVARCHAR (450)   NULL,
    [Indexed_String03]   NVARCHAR (450)   NULL,
    [Indexed_Binary01]   VARBINARY (900)  NULL,
    CONSTRAINT [PK_tblVisitorGroupStatistic] PRIMARY KEY CLUSTERED ([pkId] ASC, [Row] ASC)
);


GO
PRINT N'Creating [dbo].[tblVisitorGroupStatistic].[IDX_tblVisitorGroupStatistic_StoreName]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblVisitorGroupStatistic_StoreName]
    ON [dbo].[tblVisitorGroupStatistic]([StoreName] ASC);


GO
PRINT N'Creating [dbo].[tblVisitorGroupStatistic].[IDX_tblVisitorGroupStatistic_Indexed_Boolean01]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblVisitorGroupStatistic_Indexed_Boolean01]
    ON [dbo].[tblVisitorGroupStatistic]([Indexed_Boolean01] ASC);


GO
PRINT N'Creating [dbo].[tblVisitorGroupStatistic].[IDX_tblVisitorGroupStatistic_Indexed_Integer01]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblVisitorGroupStatistic_Indexed_Integer01]
    ON [dbo].[tblVisitorGroupStatistic]([Indexed_Integer01] ASC);


GO
PRINT N'Creating [dbo].[tblVisitorGroupStatistic].[IDX_tblVisitorGroupStatistic_Indexed_Integer02]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblVisitorGroupStatistic_Indexed_Integer02]
    ON [dbo].[tblVisitorGroupStatistic]([Indexed_Integer02] ASC);


GO
PRINT N'Creating [dbo].[tblVisitorGroupStatistic].[IDX_tblVisitorGroupStatistic_Indexed_Integer03]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblVisitorGroupStatistic_Indexed_Integer03]
    ON [dbo].[tblVisitorGroupStatistic]([Indexed_Integer03] ASC);


GO
PRINT N'Creating [dbo].[tblVisitorGroupStatistic].[IDX_tblVisitorGroupStatistic_Indexed_Long01]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblVisitorGroupStatistic_Indexed_Long01]
    ON [dbo].[tblVisitorGroupStatistic]([Indexed_Long01] ASC);


GO
PRINT N'Creating [dbo].[tblVisitorGroupStatistic].[IDX_tblVisitorGroupStatistic_Indexed_Long02]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblVisitorGroupStatistic_Indexed_Long02]
    ON [dbo].[tblVisitorGroupStatistic]([Indexed_Long02] ASC);


GO
PRINT N'Creating [dbo].[tblVisitorGroupStatistic].[IDX_tblVisitorGroupStatistic_Indexed_DateTime01]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblVisitorGroupStatistic_Indexed_DateTime01]
    ON [dbo].[tblVisitorGroupStatistic]([Indexed_DateTime01] ASC);


GO
PRINT N'Creating [dbo].[tblVisitorGroupStatistic].[IDX_tblVisitorGroupStatistic_Indexed_Guid01]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblVisitorGroupStatistic_Indexed_Guid01]
    ON [dbo].[tblVisitorGroupStatistic]([Indexed_Guid01] ASC);


GO
PRINT N'Creating [dbo].[tblVisitorGroupStatistic].[IDX_tblVisitorGroupStatistic_Indexed_Float01]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblVisitorGroupStatistic_Indexed_Float01]
    ON [dbo].[tblVisitorGroupStatistic]([Indexed_Float01] ASC);


GO
PRINT N'Creating [dbo].[tblVisitorGroupStatistic].[IDX_tblVisitorGroupStatistic_Indexed_Float02]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblVisitorGroupStatistic_Indexed_Float02]
    ON [dbo].[tblVisitorGroupStatistic]([Indexed_Float02] ASC);


GO
PRINT N'Creating [dbo].[tblVisitorGroupStatistic].[IDX_tblVisitorGroupStatistic_Indexed_Float03]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblVisitorGroupStatistic_Indexed_Float03]
    ON [dbo].[tblVisitorGroupStatistic]([Indexed_Float03] ASC);


GO
PRINT N'Creating [dbo].[tblVisitorGroupStatistic].[IDX_tblVisitorGroupStatistic_Indexed_String01]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblVisitorGroupStatistic_Indexed_String01]
    ON [dbo].[tblVisitorGroupStatistic]([Indexed_String01] ASC);


GO
PRINT N'Creating [dbo].[tblVisitorGroupStatistic].[IDX_tblVisitorGroupStatistic_Indexed_String02]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblVisitorGroupStatistic_Indexed_String02]
    ON [dbo].[tblVisitorGroupStatistic]([Indexed_String02] ASC);


GO
PRINT N'Creating [dbo].[tblVisitorGroupStatistic].[IDX_tblVisitorGroupStatistic_Indexed_String03]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblVisitorGroupStatistic_Indexed_String03]
    ON [dbo].[tblVisitorGroupStatistic]([Indexed_String03] ASC);


GO
PRINT N'Creating [dbo].[tblVisitorGroupStatistic].[IDX_tblVisitorGroupStatistic_Indexed_Binary01]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblVisitorGroupStatistic_Indexed_Binary01]
    ON [dbo].[tblVisitorGroupStatistic]([Indexed_Binary01] ASC);


GO
PRINT N'Creating [dbo].[tblSystemBigTable]...';


GO
CREATE TABLE [dbo].[tblSystemBigTable] (
    [pkId]               BIGINT           NOT NULL,
    [Row]                INT              NOT NULL,
    [StoreName]          NVARCHAR (375)   NOT NULL,
    [ItemType]           NVARCHAR (2000)  NOT NULL,
    [Boolean01]          BIT              NULL,
    [Boolean02]          BIT              NULL,
    [Boolean03]          BIT              NULL,
    [Boolean04]          BIT              NULL,
    [Boolean05]          BIT              NULL,
    [Integer01]          INT              NULL,
    [Integer02]          INT              NULL,
    [Integer03]          INT              NULL,
    [Integer04]          INT              NULL,
    [Integer05]          INT              NULL,
    [Integer06]          INT              NULL,
    [Integer07]          INT              NULL,
    [Integer08]          INT              NULL,
    [Integer09]          INT              NULL,
    [Integer10]          INT              NULL,
    [Long01]             BIGINT           NULL,
    [Long02]             BIGINT           NULL,
    [Long03]             BIGINT           NULL,
    [Long04]             BIGINT           NULL,
    [Long05]             BIGINT           NULL,
    [DateTime01]         DATETIME         NULL,
    [DateTime02]         DATETIME         NULL,
    [DateTime03]         DATETIME         NULL,
    [DateTime04]         DATETIME         NULL,
    [DateTime05]         DATETIME         NULL,
    [Guid01]             UNIQUEIDENTIFIER NULL,
    [Guid02]             UNIQUEIDENTIFIER NULL,
    [Guid03]             UNIQUEIDENTIFIER NULL,
    [Float01]            FLOAT (53)       NULL,
    [Float02]            FLOAT (53)       NULL,
    [Float03]            FLOAT (53)       NULL,
    [Float04]            FLOAT (53)       NULL,
    [Float05]            FLOAT (53)       NULL,
    [Float06]            FLOAT (53)       NULL,
    [Float07]            FLOAT (53)       NULL,
    [String01]           NVARCHAR (MAX)   NULL,
    [String02]           NVARCHAR (MAX)   NULL,
    [String03]           NVARCHAR (MAX)   NULL,
    [String04]           NVARCHAR (MAX)   NULL,
    [String05]           NVARCHAR (MAX)   NULL,
    [String06]           NVARCHAR (MAX)   NULL,
    [String07]           NVARCHAR (MAX)   NULL,
    [String08]           NVARCHAR (MAX)   NULL,
    [String09]           NVARCHAR (MAX)   NULL,
    [String10]           NVARCHAR (MAX)   NULL,
    [Binary01]           VARBINARY (MAX)  NULL,
    [Binary02]           VARBINARY (MAX)  NULL,
    [Binary03]           VARBINARY (MAX)  NULL,
    [Binary04]           VARBINARY (MAX)  NULL,
    [Binary05]           VARBINARY (MAX)  NULL,
    [Indexed_Boolean01]  BIT              NULL,
    [Indexed_Integer01]  INT              NULL,
    [Indexed_Integer02]  INT              NULL,
    [Indexed_Integer03]  INT              NULL,
    [Indexed_Long01]     BIGINT           NULL,
    [Indexed_Long02]     BIGINT           NULL,
    [Indexed_DateTime01] DATETIME         NULL,
    [Indexed_Guid01]     UNIQUEIDENTIFIER NULL,
    [Indexed_Float01]    FLOAT (53)       NULL,
    [Indexed_Float02]    FLOAT (53)       NULL,
    [Indexed_Float03]    FLOAT (53)       NULL,
    [Indexed_String01]   NVARCHAR (450)   NULL,
    [Indexed_String02]   NVARCHAR (450)   NULL,
    [Indexed_String03]   NVARCHAR (450)   NULL,
    [Indexed_Binary01]   VARBINARY (900)  NULL,
    [Decimal01]          DECIMAL (18, 3)  NULL,
    [Decimal02]          DECIMAL (18, 3)  NULL,
    [Indexed_Decimal01]  DECIMAL (18, 3)  NULL,
    CONSTRAINT [PK_tblSystemBigTable] PRIMARY KEY CLUSTERED ([pkId] ASC, [Row] ASC)
);


GO
PRINT N'Creating [dbo].[tblSystemBigTable].[IDX_tblSystemBigTable_StoreName]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblSystemBigTable_StoreName]
    ON [dbo].[tblSystemBigTable]([StoreName] ASC);


GO
PRINT N'Creating [dbo].[tblSystemBigTable].[IDX_tblSystemBigTable_Indexed_Boolean01]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblSystemBigTable_Indexed_Boolean01]
    ON [dbo].[tblSystemBigTable]([Indexed_Boolean01] ASC);


GO
PRINT N'Creating [dbo].[tblSystemBigTable].[IDX_tblSystemBigTable_Indexed_Integer01]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblSystemBigTable_Indexed_Integer01]
    ON [dbo].[tblSystemBigTable]([Indexed_Integer01] ASC);


GO
PRINT N'Creating [dbo].[tblSystemBigTable].[IDX_tblSystemBigTable_Indexed_Integer02]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblSystemBigTable_Indexed_Integer02]
    ON [dbo].[tblSystemBigTable]([Indexed_Integer02] ASC);


GO
PRINT N'Creating [dbo].[tblSystemBigTable].[IDX_tblSystemBigTable_Indexed_Integer03]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblSystemBigTable_Indexed_Integer03]
    ON [dbo].[tblSystemBigTable]([Indexed_Integer03] ASC);


GO
PRINT N'Creating [dbo].[tblSystemBigTable].[IDX_tblSystemBigTable_Indexed_Long01]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblSystemBigTable_Indexed_Long01]
    ON [dbo].[tblSystemBigTable]([Indexed_Long01] ASC);


GO
PRINT N'Creating [dbo].[tblSystemBigTable].[IDX_tblSystemBigTable_Indexed_Long02]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblSystemBigTable_Indexed_Long02]
    ON [dbo].[tblSystemBigTable]([Indexed_Long02] ASC);


GO
PRINT N'Creating [dbo].[tblSystemBigTable].[IDX_tblSystemBigTable_Indexed_DateTime01]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblSystemBigTable_Indexed_DateTime01]
    ON [dbo].[tblSystemBigTable]([Indexed_DateTime01] ASC);


GO
PRINT N'Creating [dbo].[tblSystemBigTable].[IDX_tblSystemBigTable_Indexed_Guid01]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblSystemBigTable_Indexed_Guid01]
    ON [dbo].[tblSystemBigTable]([Indexed_Guid01] ASC);


GO
PRINT N'Creating [dbo].[tblSystemBigTable].[IDX_tblSystemBigTable_Indexed_Float01]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblSystemBigTable_Indexed_Float01]
    ON [dbo].[tblSystemBigTable]([Indexed_Float01] ASC);


GO
PRINT N'Creating [dbo].[tblSystemBigTable].[IDX_tblSystemBigTable_Indexed_Float02]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblSystemBigTable_Indexed_Float02]
    ON [dbo].[tblSystemBigTable]([Indexed_Float02] ASC);


GO
PRINT N'Creating [dbo].[tblSystemBigTable].[IDX_tblSystemBigTable_Indexed_Float03]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblSystemBigTable_Indexed_Float03]
    ON [dbo].[tblSystemBigTable]([Indexed_Float03] ASC);


GO
PRINT N'Creating [dbo].[tblSystemBigTable].[IDX_tblSystemBigTable_Indexed_Decimal01]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblSystemBigTable_Indexed_Decimal01]
    ON [dbo].[tblSystemBigTable]([Indexed_Decimal01] ASC);


GO
PRINT N'Creating [dbo].[tblSystemBigTable].[IDX_tblSystemBigTable_Indexed_String01]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblSystemBigTable_Indexed_String01]
    ON [dbo].[tblSystemBigTable]([Indexed_String01] ASC);


GO
PRINT N'Creating [dbo].[tblSystemBigTable].[IDX_tblSystemBigTable_Indexed_String02]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblSystemBigTable_Indexed_String02]
    ON [dbo].[tblSystemBigTable]([Indexed_String02] ASC);


GO
PRINT N'Creating [dbo].[tblSystemBigTable].[IDX_tblSystemBigTable_Indexed_String03]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblSystemBigTable_Indexed_String03]
    ON [dbo].[tblSystemBigTable]([Indexed_String03] ASC);


GO
PRINT N'Creating [dbo].[tblSystemBigTable].[IDX_tblSystemBigTable_Indexed_Binary01]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblSystemBigTable_Indexed_Binary01]
    ON [dbo].[tblSystemBigTable]([Indexed_Binary01] ASC);


GO
PRINT N'Creating [dbo].[tblIndexRequestLog]...';


GO
CREATE TABLE [dbo].[tblIndexRequestLog] (
    [pkId]               BIGINT           NOT NULL,
    [Row]                INT              NOT NULL,
    [StoreName]          NVARCHAR (375)   NOT NULL,
    [ItemType]           NVARCHAR (2000)  NOT NULL,
    [Boolean01]          BIT              NULL,
    [Boolean02]          BIT              NULL,
    [Boolean03]          BIT              NULL,
    [Boolean04]          BIT              NULL,
    [Boolean05]          BIT              NULL,
    [Integer01]          INT              NULL,
    [Integer02]          INT              NULL,
    [Integer03]          INT              NULL,
    [Integer04]          INT              NULL,
    [Integer05]          INT              NULL,
    [Integer06]          INT              NULL,
    [Integer07]          INT              NULL,
    [Integer08]          INT              NULL,
    [Integer09]          INT              NULL,
    [Integer10]          INT              NULL,
    [Long01]             BIGINT           NULL,
    [Long02]             BIGINT           NULL,
    [Long03]             BIGINT           NULL,
    [Long04]             BIGINT           NULL,
    [Long05]             BIGINT           NULL,
    [DateTime01]         DATETIME         NULL,
    [DateTime02]         DATETIME         NULL,
    [DateTime03]         DATETIME         NULL,
    [DateTime04]         DATETIME         NULL,
    [DateTime05]         DATETIME         NULL,
    [Guid01]             UNIQUEIDENTIFIER NULL,
    [Guid02]             UNIQUEIDENTIFIER NULL,
    [Guid03]             UNIQUEIDENTIFIER NULL,
    [Float01]            FLOAT (53)       NULL,
    [Float02]            FLOAT (53)       NULL,
    [Float03]            FLOAT (53)       NULL,
    [Float04]            FLOAT (53)       NULL,
    [Float05]            FLOAT (53)       NULL,
    [Float06]            FLOAT (53)       NULL,
    [Float07]            FLOAT (53)       NULL,
    [String01]           NVARCHAR (MAX)   NULL,
    [String02]           NVARCHAR (MAX)   NULL,
    [String03]           NVARCHAR (MAX)   NULL,
    [String04]           NVARCHAR (MAX)   NULL,
    [String05]           NVARCHAR (MAX)   NULL,
    [String06]           NVARCHAR (MAX)   NULL,
    [String07]           NVARCHAR (MAX)   NULL,
    [String08]           NVARCHAR (MAX)   NULL,
    [String09]           NVARCHAR (MAX)   NULL,
    [String10]           NVARCHAR (MAX)   NULL,
    [Binary01]           VARBINARY (MAX)  NULL,
    [Binary02]           VARBINARY (MAX)  NULL,
    [Binary03]           VARBINARY (MAX)  NULL,
    [Binary04]           VARBINARY (MAX)  NULL,
    [Binary05]           VARBINARY (MAX)  NULL,
    [Indexed_Boolean01]  BIT              NULL,
    [Indexed_Integer01]  INT              NULL,
    [Indexed_Integer02]  INT              NULL,
    [Indexed_Integer03]  INT              NULL,
    [Indexed_Long01]     BIGINT           NULL,
    [Indexed_Long02]     BIGINT           NULL,
    [Indexed_DateTime01] DATETIME         NULL,
    [Indexed_Guid01]     UNIQUEIDENTIFIER NULL,
    [Indexed_Float01]    FLOAT (53)       NULL,
    [Indexed_Float02]    FLOAT (53)       NULL,
    [Indexed_Float03]    FLOAT (53)       NULL,
    [Indexed_String01]   NVARCHAR (450)   NULL,
    [Indexed_String02]   NVARCHAR (450)   NULL,
    [Indexed_String03]   NVARCHAR (450)   NULL,
    [Indexed_Binary01]   VARBINARY (900)  NULL,
    CONSTRAINT [PK_tblIndexRequestLog] PRIMARY KEY CLUSTERED ([pkId] ASC, [Row] ASC)
);


GO
PRINT N'Creating [dbo].[tblIndexRequestLog].[IDX_tblIndexRequestLog_StoreName]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblIndexRequestLog_StoreName]
    ON [dbo].[tblIndexRequestLog]([StoreName] ASC);


GO
PRINT N'Creating [dbo].[tblIndexRequestLog].[IDX_tblIndexRequestLog_Indexed_DateTime01]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblIndexRequestLog_Indexed_DateTime01]
    ON [dbo].[tblIndexRequestLog]([Indexed_DateTime01] ASC);


GO
PRINT N'Creating [dbo].[tblIndexRequestLog].[IDX_tblIndexRequestLog_Indexed_String01]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblIndexRequestLog_Indexed_String01]
    ON [dbo].[tblIndexRequestLog]([Indexed_String01] ASC);


GO
PRINT N'Creating [dbo].[tblEntityType]...';


GO
CREATE TABLE [dbo].[tblEntityType] (
    [intID]   INT           IDENTITY (1, 1) NOT NULL,
    [strName] VARCHAR (400) NOT NULL,
    CONSTRAINT [PK_tblEntityType] PRIMARY KEY CLUSTERED ([intID] ASC)
);


GO
PRINT N'Creating [dbo].[tblEntityGuid]...';


GO
CREATE TABLE [dbo].[tblEntityGuid] (
    [intObjectTypeID] INT              NOT NULL,
    [intObjectID]     INT              NOT NULL,
    [unqID]           UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_tblEntityGuid] PRIMARY KEY CLUSTERED ([intObjectTypeID] ASC, [intObjectID] ASC)
);


GO
PRINT N'Creating [dbo].[tblChangeNotificationQueuedString]...';


GO
CREATE TABLE [dbo].[tblChangeNotificationQueuedString] (
    [ProcessorId]  UNIQUEIDENTIFIER NOT NULL,
    [ConnectionId] UNIQUEIDENTIFIER NULL,
    [QueueOrder]   INT              NOT NULL,
    [Value]        NVARCHAR (450)   COLLATE Latin1_General_BIN2 NOT NULL
);


GO
PRINT N'Creating [dbo].[tblChangeNotificationQueuedString].[IDX_tblChangeNotificationQueuedString]...';


GO
CREATE CLUSTERED INDEX [IDX_tblChangeNotificationQueuedString]
    ON [dbo].[tblChangeNotificationQueuedString]([ProcessorId] ASC, [QueueOrder] ASC);


GO
PRINT N'Creating [dbo].[tblChangeNotificationQueuedInt]...';


GO
CREATE TABLE [dbo].[tblChangeNotificationQueuedInt] (
    [ProcessorId]  UNIQUEIDENTIFIER NOT NULL,
    [ConnectionId] UNIQUEIDENTIFIER NULL,
    [QueueOrder]   INT              NOT NULL,
    [Value]        INT              NOT NULL
);


GO
PRINT N'Creating [dbo].[tblChangeNotificationQueuedInt].[IDX_tblChangeNotificationQueuedInt]...';


GO
CREATE CLUSTERED INDEX [IDX_tblChangeNotificationQueuedInt]
    ON [dbo].[tblChangeNotificationQueuedInt]([ProcessorId] ASC, [QueueOrder] ASC);


GO
PRINT N'Creating [dbo].[tblChangeNotificationQueuedGuid]...';


GO
CREATE TABLE [dbo].[tblChangeNotificationQueuedGuid] (
    [ProcessorId]  UNIQUEIDENTIFIER NOT NULL,
    [ConnectionId] UNIQUEIDENTIFIER NULL,
    [QueueOrder]   INT              NOT NULL,
    [Value]        UNIQUEIDENTIFIER NOT NULL
);


GO
PRINT N'Creating [dbo].[tblChangeNotificationQueuedGuid].[IDX_tblChangeNotificationQueuedGuid]...';


GO
CREATE CLUSTERED INDEX [IDX_tblChangeNotificationQueuedGuid]
    ON [dbo].[tblChangeNotificationQueuedGuid]([ProcessorId] ASC, [QueueOrder] ASC);


GO
PRINT N'Creating [dbo].[tblChangeNotificationProcessor]...';


GO
CREATE TABLE [dbo].[tblChangeNotificationProcessor] (
    [ProcessorId]                UNIQUEIDENTIFIER NOT NULL,
    [ChangeNotificationDataType] NVARCHAR (30)    NOT NULL,
    [ProcessorName]              NVARCHAR (4000)  NOT NULL,
    [ProcessorStatus]            NVARCHAR (30)    NOT NULL,
    [NextQueueOrderValue]        INT              NOT NULL,
    [LastConsistentDbUtc]        DATETIME         NULL,
    CONSTRAINT [PK_ChangeNotificationProcessor] PRIMARY KEY CLUSTERED ([ProcessorId] ASC)
);


GO
PRINT N'Creating [dbo].[tblChangeNotificationConnection]...';


GO
CREATE TABLE [dbo].[tblChangeNotificationConnection] (
    [ConnectionId]      UNIQUEIDENTIFIER NOT NULL,
    [ProcessorId]       UNIQUEIDENTIFIER NOT NULL,
    [IsOpen]            BIT              NOT NULL,
    [LastActivityDbUtc] DATETIME         NOT NULL,
    CONSTRAINT [PK_ChangeNotificationConnection] PRIMARY KEY CLUSTERED ([ConnectionId] ASC)
);


GO
PRINT N'Creating [dbo].[tblBigTableStoreInfo]...';


GO
CREATE TABLE [dbo].[tblBigTableStoreInfo] (
    [fkStoreId]       BIGINT          NOT NULL,
    [PropertyName]    NVARCHAR (75)   NOT NULL,
    [PropertyMapType] NVARCHAR (64)   NOT NULL,
    [PropertyIndex]   INT             NOT NULL,
    [PropertyType]    NVARCHAR (2000) NOT NULL,
    [Active]          BIT             NOT NULL,
    [Version]         INT             NOT NULL,
    [ColumnName]      NVARCHAR (128)  NULL,
    [ColumnRowIndex]  INT             NULL,
    CONSTRAINT [PK_tblBigTableStoreInfo] PRIMARY KEY CLUSTERED ([fkStoreId] ASC, [PropertyName] ASC)
);


GO
PRINT N'Creating [dbo].[tblBigTableStoreConfig]...';


GO
CREATE TABLE [dbo].[tblBigTableStoreConfig] (
    [pkId]         BIGINT         IDENTITY (1, 1) NOT NULL,
    [StoreName]    NVARCHAR (375) NOT NULL,
    [TableName]    NVARCHAR (128) NULL,
    [EntityTypeId] INT            NULL,
    CONSTRAINT [PK_tblBigTableStoreConfig] PRIMARY KEY CLUSTERED ([pkId] ASC)
);


GO
PRINT N'Creating [dbo].[tblBigTableStoreConfig].[IDX_tblBigTableStoreConfig_StoreName]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblBigTableStoreConfig_StoreName]
    ON [dbo].[tblBigTableStoreConfig]([StoreName] ASC);


GO
PRINT N'Creating [dbo].[tblBigTableReference]...';


GO
CREATE TABLE [dbo].[tblBigTableReference] (
    [pkId]             BIGINT           NOT NULL,
    [Type]             INT              NOT NULL,
    [PropertyName]     NVARCHAR (75)    NOT NULL,
    [CollectionType]   NVARCHAR (2000)  NULL,
    [ElementType]      NVARCHAR (2000)  NULL,
    [ElementStoreName] NVARCHAR (375)   NULL,
    [IsKey]            BIT              NOT NULL,
    [Index]            INT              NOT NULL,
    [BooleanValue]     BIT              NULL,
    [IntegerValue]     INT              NULL,
    [LongValue]        BIGINT           NULL,
    [DateTimeValue]    DATETIME         NULL,
    [GuidValue]        UNIQUEIDENTIFIER NULL,
    [FloatValue]       FLOAT (53)       NULL,
    [StringValue]      NVARCHAR (MAX)   NULL,
    [BinaryValue]      VARBINARY (MAX)  NULL,
    [RefIdValue]       BIGINT           NULL,
    [ExternalIdValue]  BIGINT           NULL,
    [DecimalValue]     DECIMAL (18, 3)  NULL,
    CONSTRAINT [PK_tblBigTableReference] PRIMARY KEY CLUSTERED ([pkId] ASC, [PropertyName] ASC, [IsKey] ASC, [Index] ASC)
);


GO
PRINT N'Creating [dbo].[tblBigTableReference].[IDX_tblBigTableReference_RefIdValue]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblBigTableReference_RefIdValue]
    ON [dbo].[tblBigTableReference]([RefIdValue] ASC);


GO
PRINT N'Creating [dbo].[tblBigTableIdentity]...';


GO
CREATE TABLE [dbo].[tblBigTableIdentity] (
    [pkId]      BIGINT           IDENTITY (1, 1) NOT NULL,
    [Guid]      UNIQUEIDENTIFIER NOT NULL,
    [StoreName] NVARCHAR (375)   NOT NULL,
    CONSTRAINT [PK_tblBigTableIdentity] PRIMARY KEY CLUSTERED ([pkId] ASC)
);


GO
PRINT N'Creating [dbo].[tblBigTableIdentity].[IDX_tblBigTableIdentity_Guid]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblBigTableIdentity_Guid]
    ON [dbo].[tblBigTableIdentity]([Guid] ASC);


GO
PRINT N'Creating [dbo].[tblBigTable]...';


GO
CREATE TABLE [dbo].[tblBigTable] (
    [pkId]               BIGINT           NOT NULL,
    [Row]                INT              NOT NULL,
    [StoreName]          NVARCHAR (375)   NOT NULL,
    [ItemType]           NVARCHAR (2000)  NOT NULL,
    [Boolean01]          BIT              NULL,
    [Boolean02]          BIT              NULL,
    [Boolean03]          BIT              NULL,
    [Boolean04]          BIT              NULL,
    [Boolean05]          BIT              NULL,
    [Integer01]          INT              NULL,
    [Integer02]          INT              NULL,
    [Integer03]          INT              NULL,
    [Integer04]          INT              NULL,
    [Integer05]          INT              NULL,
    [Integer06]          INT              NULL,
    [Integer07]          INT              NULL,
    [Integer08]          INT              NULL,
    [Integer09]          INT              NULL,
    [Integer10]          INT              NULL,
    [Long01]             BIGINT           NULL,
    [Long02]             BIGINT           NULL,
    [Long03]             BIGINT           NULL,
    [Long04]             BIGINT           NULL,
    [Long05]             BIGINT           NULL,
    [DateTime01]         DATETIME         NULL,
    [DateTime02]         DATETIME         NULL,
    [DateTime03]         DATETIME         NULL,
    [DateTime04]         DATETIME         NULL,
    [DateTime05]         DATETIME         NULL,
    [Guid01]             UNIQUEIDENTIFIER NULL,
    [Guid02]             UNIQUEIDENTIFIER NULL,
    [Guid03]             UNIQUEIDENTIFIER NULL,
    [Float01]            FLOAT (53)       NULL,
    [Float02]            FLOAT (53)       NULL,
    [Float03]            FLOAT (53)       NULL,
    [Float04]            FLOAT (53)       NULL,
    [Float05]            FLOAT (53)       NULL,
    [Float06]            FLOAT (53)       NULL,
    [Float07]            FLOAT (53)       NULL,
    [Decimal01]          DECIMAL (18, 3)  NULL,
    [Decimal02]          DECIMAL (18, 3)  NULL,
    [String01]           NVARCHAR (MAX)   NULL,
    [String02]           NVARCHAR (MAX)   NULL,
    [String03]           NVARCHAR (MAX)   NULL,
    [String04]           NVARCHAR (MAX)   NULL,
    [String05]           NVARCHAR (MAX)   NULL,
    [String06]           NVARCHAR (MAX)   NULL,
    [String07]           NVARCHAR (MAX)   NULL,
    [String08]           NVARCHAR (MAX)   NULL,
    [String09]           NVARCHAR (MAX)   NULL,
    [String10]           NVARCHAR (MAX)   NULL,
    [Binary01]           VARBINARY (MAX)  NULL,
    [Binary02]           VARBINARY (MAX)  NULL,
    [Binary03]           VARBINARY (MAX)  NULL,
    [Binary04]           VARBINARY (MAX)  NULL,
    [Binary05]           VARBINARY (MAX)  NULL,
    [Indexed_Boolean01]  BIT              NULL,
    [Indexed_Integer01]  INT              NULL,
    [Indexed_Integer02]  INT              NULL,
    [Indexed_Integer03]  INT              NULL,
    [Indexed_Long01]     BIGINT           NULL,
    [Indexed_Long02]     BIGINT           NULL,
    [Indexed_DateTime01] DATETIME         NULL,
    [Indexed_Guid01]     UNIQUEIDENTIFIER NULL,
    [Indexed_Float01]    FLOAT (53)       NULL,
    [Indexed_Float02]    FLOAT (53)       NULL,
    [Indexed_Float03]    FLOAT (53)       NULL,
    [Indexed_Decimal01]  DECIMAL (18, 3)  NULL,
    [Indexed_String01]   NVARCHAR (450)   NULL,
    [Indexed_String02]   NVARCHAR (450)   NULL,
    [Indexed_String03]   NVARCHAR (450)   NULL,
    [Indexed_Binary01]   VARBINARY (900)  NULL,
    CONSTRAINT [PK_tblBigTable] PRIMARY KEY CLUSTERED ([pkId] ASC, [Row] ASC)
);


GO
PRINT N'Creating [dbo].[tblBigTable].[IDX_tblBigTable_StoreName]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblBigTable_StoreName]
    ON [dbo].[tblBigTable]([StoreName] ASC);


GO
PRINT N'Creating [dbo].[tblBigTable].[IDX_tblBigTable_Indexed_Boolean01]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblBigTable_Indexed_Boolean01]
    ON [dbo].[tblBigTable]([Indexed_Boolean01] ASC);


GO
PRINT N'Creating [dbo].[tblBigTable].[IDX_tblBigTable_Indexed_Integer01]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblBigTable_Indexed_Integer01]
    ON [dbo].[tblBigTable]([Indexed_Integer01] ASC);


GO
PRINT N'Creating [dbo].[tblBigTable].[IDX_tblBigTable_Indexed_Integer02]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblBigTable_Indexed_Integer02]
    ON [dbo].[tblBigTable]([Indexed_Integer02] ASC);


GO
PRINT N'Creating [dbo].[tblBigTable].[IDX_tblBigTable_Indexed_Integer03]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblBigTable_Indexed_Integer03]
    ON [dbo].[tblBigTable]([Indexed_Integer03] ASC);


GO
PRINT N'Creating [dbo].[tblBigTable].[IDX_tblBigTable_Indexed_Long01]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblBigTable_Indexed_Long01]
    ON [dbo].[tblBigTable]([Indexed_Long01] ASC);


GO
PRINT N'Creating [dbo].[tblBigTable].[IDX_tblBigTable_Indexed_Long02]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblBigTable_Indexed_Long02]
    ON [dbo].[tblBigTable]([Indexed_Long02] ASC);


GO
PRINT N'Creating [dbo].[tblBigTable].[IDX_tblBigTable_Indexed_DateTime01]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblBigTable_Indexed_DateTime01]
    ON [dbo].[tblBigTable]([Indexed_DateTime01] ASC);


GO
PRINT N'Creating [dbo].[tblBigTable].[IDX_tblBigTable_Indexed_Guid01]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblBigTable_Indexed_Guid01]
    ON [dbo].[tblBigTable]([Indexed_Guid01] ASC);


GO
PRINT N'Creating [dbo].[tblBigTable].[IDX_tblBigTable_Indexed_Float01]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblBigTable_Indexed_Float01]
    ON [dbo].[tblBigTable]([Indexed_Float01] ASC);


GO
PRINT N'Creating [dbo].[tblBigTable].[IDX_tblBigTable_Indexed_Float02]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblBigTable_Indexed_Float02]
    ON [dbo].[tblBigTable]([Indexed_Float02] ASC);


GO
PRINT N'Creating [dbo].[tblBigTable].[IDX_tblBigTable_Indexed_Float03]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblBigTable_Indexed_Float03]
    ON [dbo].[tblBigTable]([Indexed_Float03] ASC);


GO
PRINT N'Creating [dbo].[tblBigTable].[IDX_tblBigTable_Indexed_Decimal01]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblBigTable_Indexed_Decimal01]
    ON [dbo].[tblBigTable]([Indexed_Decimal01] ASC);


GO
PRINT N'Creating [dbo].[tblBigTable].[IDX_tblBigTable_Indexed_String01]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblBigTable_Indexed_String01]
    ON [dbo].[tblBigTable]([Indexed_String01] ASC);


GO
PRINT N'Creating [dbo].[tblBigTable].[IDX_tblBigTable_Indexed_String02]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblBigTable_Indexed_String02]
    ON [dbo].[tblBigTable]([Indexed_String02] ASC);


GO
PRINT N'Creating [dbo].[tblBigTable].[IDX_tblBigTable_Indexed_String03]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblBigTable_Indexed_String03]
    ON [dbo].[tblBigTable]([Indexed_String03] ASC);


GO
PRINT N'Creating [dbo].[tblBigTable].[IDX_tblBigTable_Indexed_Binary01]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblBigTable_Indexed_Binary01]
    ON [dbo].[tblBigTable]([Indexed_Binary01] ASC);


GO
PRINT N'Creating [dbo].[tblXFormData]...';


GO
CREATE TABLE [dbo].[tblXFormData] (
    [pkId]             BIGINT           NOT NULL,
    [Row]              INT              NOT NULL,
    [StoreName]        NVARCHAR (375)   NOT NULL,
    [ItemType]         NVARCHAR (2000)  NOT NULL,
    [ChannelOptions]   INT              NULL,
    [DatePosted]       DATETIME         NULL,
    [FormId]           UNIQUEIDENTIFIER NULL,
    [PageGuid]         UNIQUEIDENTIFIER NULL,
    [UserName]         NVARCHAR (450)   NULL,
    [String01]         NVARCHAR (MAX)   NULL,
    [String02]         NVARCHAR (MAX)   NULL,
    [String03]         NVARCHAR (MAX)   NULL,
    [String04]         NVARCHAR (MAX)   NULL,
    [String05]         NVARCHAR (MAX)   NULL,
    [String06]         NVARCHAR (MAX)   NULL,
    [String07]         NVARCHAR (MAX)   NULL,
    [String08]         NVARCHAR (MAX)   NULL,
    [String09]         NVARCHAR (MAX)   NULL,
    [String10]         NVARCHAR (MAX)   NULL,
    [String11]         NVARCHAR (MAX)   NULL,
    [String12]         NVARCHAR (MAX)   NULL,
    [String13]         NVARCHAR (MAX)   NULL,
    [String14]         NVARCHAR (MAX)   NULL,
    [String15]         NVARCHAR (MAX)   NULL,
    [String16]         NVARCHAR (MAX)   NULL,
    [String17]         NVARCHAR (MAX)   NULL,
    [String18]         NVARCHAR (MAX)   NULL,
    [String19]         NVARCHAR (MAX)   NULL,
    [String20]         NVARCHAR (MAX)   NULL,
    [Indexed_String01] NVARCHAR (450)   NULL,
    [Indexed_String02] NVARCHAR (450)   NULL,
    [Indexed_String03] NVARCHAR (450)   NULL,
    CONSTRAINT [PK_tblXFormData] PRIMARY KEY CLUSTERED ([pkId] ASC, [Row] ASC)
);


GO
PRINT N'Creating [dbo].[tblXFormData].[IDX_tblXFormData_String01]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblXFormData_String01]
    ON [dbo].[tblXFormData]([Indexed_String01] ASC);


GO
PRINT N'Creating [dbo].[tblXFormData].[IDX_tblXFormData_String02]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblXFormData_String02]
    ON [dbo].[tblXFormData]([Indexed_String02] ASC);


GO
PRINT N'Creating [dbo].[tblXFormData].[IDX_tblXFormData_String03]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblXFormData_String03]
    ON [dbo].[tblXFormData]([Indexed_String03] ASC);


GO
PRINT N'Creating [dbo].[tblChangeLog]...';


GO
CREATE TABLE [dbo].[tblChangeLog] (
    [pkID]       BIGINT         IDENTITY (1, 1) NOT NULL,
    [LogData]    NVARCHAR (MAX) NULL,
    [ChangeDate] DATETIME       NOT NULL,
    [Category]   INT            NOT NULL,
    [Action]     INT            NOT NULL,
    [ChangedBy]  NVARCHAR (255) NOT NULL,
    CONSTRAINT [PK_tblChangeLog] PRIMARY KEY CLUSTERED ([pkID] ASC)
);


GO
PRINT N'Creating [dbo].[tblChangeLog].[IDX_tblChangeLog_ChangeDate]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblChangeLog_ChangeDate]
    ON [dbo].[tblChangeLog]([ChangeDate] ASC);


GO
PRINT N'Creating [dbo].[tblChangeLog].[IDX_tblChangeLog_Pkid_ChangeDate]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblChangeLog_Pkid_ChangeDate]
    ON [dbo].[tblChangeLog]([pkID] ASC, [ChangeDate] ASC);


GO
PRINT N'Creating [dbo].[tblSiteConfig]...';


GO
CREATE TABLE [dbo].[tblSiteConfig] (
    [pkID]          INT            IDENTITY (1, 1) NOT NULL,
    [SiteID]        VARCHAR (250)  NOT NULL,
    [PropertyName]  VARCHAR (250)  NOT NULL,
    [PropertyValue] NVARCHAR (MAX) NOT NULL,
    CONSTRAINT [PK_tblSiteConfig] PRIMARY KEY CLUSTERED ([pkID] ASC)
);


GO
PRINT N'Creating [dbo].[tblSiteConfig].[IX_tblSiteConfig]...';


GO
CREATE NONCLUSTERED INDEX [IX_tblSiteConfig]
    ON [dbo].[tblSiteConfig]([SiteID] ASC, [PropertyName] ASC);


GO
PRINT N'Creating [dbo].[tblWindowsRelations]...';


GO
CREATE TABLE [dbo].[tblWindowsRelations] (
    [fkWindowsUser]  INT NOT NULL,
    [fkWindowsGroup] INT NOT NULL,
    CONSTRAINT [PK_tblWindowsRelations] PRIMARY KEY CLUSTERED ([fkWindowsUser] ASC, [fkWindowsGroup] ASC)
);


GO
PRINT N'Creating [dbo].[tblWindowsGroup]...';


GO
CREATE TABLE [dbo].[tblWindowsGroup] (
    [pkID]             INT            IDENTITY (1, 1) NOT NULL,
    [GroupName]        NVARCHAR (255) NOT NULL,
    [LoweredGroupName] NVARCHAR (255) NOT NULL,
    [Enabled]          BIT            NOT NULL,
    CONSTRAINT [PK_tblWindowsGroup] PRIMARY KEY CLUSTERED ([pkID] ASC)
);


GO
PRINT N'Creating [dbo].[tblWindowsGroup].[IX_tblWindowsGroup_Unique]...';


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_tblWindowsGroup_Unique]
    ON [dbo].[tblWindowsGroup]([LoweredGroupName] ASC);


GO
PRINT N'Creating [dbo].[tblWindowsUser]...';


GO
CREATE TABLE [dbo].[tblWindowsUser] (
    [pkID]            INT            IDENTITY (1, 1) NOT NULL,
    [UserName]        NVARCHAR (255) NOT NULL,
    [LoweredUserName] NVARCHAR (255) NOT NULL,
    CONSTRAINT [PK_tblWindowsUser] PRIMARY KEY CLUSTERED ([pkID] ASC)
);


GO
PRINT N'Creating [dbo].[tblWindowsUser].[IX_tblWindowsUser_Unique]...';


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_tblWindowsUser_Unique]
    ON [dbo].[tblWindowsUser]([LoweredUserName] ASC);


GO
PRINT N'Creating [dbo].[tblUniqueSequence]...';


GO
CREATE TABLE [dbo].[tblUniqueSequence] (
    [Name]      NVARCHAR (255) NOT NULL,
    [LastValue] INT            NOT NULL,
    CONSTRAINT [PK_tblUniqueSequence] PRIMARY KEY CLUSTERED ([Name] ASC)
);


GO
PRINT N'Creating [dbo].[tblLanguageBranch]...';


GO
CREATE TABLE [dbo].[tblLanguageBranch] (
    [pkID]           INT            IDENTITY (1, 1) NOT NULL,
    [LanguageID]     NCHAR (17)     NOT NULL,
    [Name]           NVARCHAR (255) NULL,
    [SortIndex]      INT            NOT NULL,
    [SystemIconPath] NVARCHAR (255) NULL,
    [URLSegment]     NVARCHAR (255) NULL,
    [ACL]            NVARCHAR (MAX) NULL,
    [Enabled]        BIT            NOT NULL,
    CONSTRAINT [PK_tblLanguageBranch] PRIMARY KEY CLUSTERED ([pkID] ASC),
    CONSTRAINT [IX_tblLanguageBranch] UNIQUE NONCLUSTERED ([LanguageID] ASC)
);


GO
PRINT N'Creating [dbo].[tblContentLanguageSetting]...';


GO
CREATE TABLE [dbo].[tblContentLanguageSetting] (
    [fkContentID]            INT             NOT NULL,
    [fkLanguageBranchID]     INT             NOT NULL,
    [fkReplacementBranchID]  INT             NULL,
    [LanguageBranchFallback] NVARCHAR (1000) NULL,
    [Active]                 BIT             NOT NULL,
    CONSTRAINT [PK_tblContentLanguageSetting] PRIMARY KEY CLUSTERED ([fkContentID] ASC, [fkLanguageBranchID] ASC)
);


GO
PRINT N'Creating [dbo].[tblContentLanguage]...';


GO
CREATE TABLE [dbo].[tblContentLanguage] (
    [fkContentID]        INT              NOT NULL,
    [fkLanguageBranchID] INT              NOT NULL,
    [ContentLinkGUID]    UNIQUEIDENTIFIER NULL,
    [fkFrameID]          INT              NULL,
    [CreatorName]        NVARCHAR (255)   NULL,
    [ChangedByName]      NVARCHAR (255)   NULL,
    [ContentGUID]        UNIQUEIDENTIFIER NOT NULL,
    [Name]               NVARCHAR (255)   NULL,
    [URLSegment]         NVARCHAR (255)   NULL,
    [LinkURL]            NVARCHAR (255)   NULL,
    [BlobUri]            NVARCHAR (255)   NULL,
    [ThumbnailUri]       NVARCHAR (255)   NULL,
    [ExternalURL]        NVARCHAR (255)   NULL,
    [AutomaticLink]      BIT              NOT NULL,
    [FetchData]          BIT              NOT NULL,
    [Created]            DATETIME         NOT NULL,
    [Changed]            DATETIME         NOT NULL,
    [Saved]              DATETIME         NOT NULL,
    [StartPublish]       DATETIME         NULL,
    [StopPublish]        DATETIME         NULL,
    [Version]            INT              NULL,
    [Status]             INT              NOT NULL,
    [DelayPublishUntil]  DATETIME         NULL,
    CONSTRAINT [PK_tblContentLanguage] PRIMARY KEY CLUSTERED ([fkContentID] ASC, [fkLanguageBranchID] ASC)
);


GO
PRINT N'Creating [dbo].[tblContentLanguage].[IDX_tblContentLanguage_ContentGUID]...';


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_tblContentLanguage_ContentGUID]
    ON [dbo].[tblContentLanguage]([ContentGUID] ASC);


GO
PRINT N'Creating [dbo].[tblContentLanguage].[IDX_tblContentLanguage_Name]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblContentLanguage_Name]
    ON [dbo].[tblContentLanguage]([Name] ASC);


GO
PRINT N'Creating [dbo].[tblContentLanguage].[IDX_tblContentLanguage_ExternalURL]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblContentLanguage_ExternalURL]
    ON [dbo].[tblContentLanguage]([ExternalURL] ASC);


GO
PRINT N'Creating [dbo].[tblContentLanguage].[IDX_tblContentLanguage_URLSegment]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblContentLanguage_URLSegment]
    ON [dbo].[tblContentLanguage]([URLSegment] ASC);


GO
PRINT N'Creating [dbo].[tblContentLanguage].[IDX_tblContentLanguage_ContentLinkGUID]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblContentLanguage_ContentLinkGUID]
    ON [dbo].[tblContentLanguage]([ContentLinkGUID] ASC);


GO
PRINT N'Creating [dbo].[tblContentLanguage].[IDX_tblContentLanguage_Version]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblContentLanguage_Version]
    ON [dbo].[tblContentLanguage]([Version] ASC);


GO
PRINT N'Creating [dbo].[tblRelation]...';


GO
CREATE TABLE [dbo].[tblRelation] (
    [FromId] NVARCHAR (100) NOT NULL,
    [ToId]   NVARCHAR (100) NOT NULL,
    [ToName] NVARCHAR (255) NULL
);


GO
PRINT N'Creating [dbo].[tblRelation].[IX_tblRelation_FromId_ToName]...';


GO
CREATE CLUSTERED INDEX [IX_tblRelation_FromId_ToName]
    ON [dbo].[tblRelation]([FromId] ASC, [ToName] ASC);


GO
PRINT N'Creating [dbo].[tblRelation].[IX_tblRelation_ToId]...';


GO
CREATE NONCLUSTERED INDEX [IX_tblRelation_ToId]
    ON [dbo].[tblRelation]([ToId] ASC);


GO
PRINT N'Creating [dbo].[tblIndexGuid]...';


GO
CREATE TABLE [dbo].[tblIndexGuid] (
    [pkID]           INT              IDENTITY (1, 1) NOT NULL,
    [fkSchemaItemId] INT              NOT NULL,
    [fkItemId]       NVARCHAR (256)   NOT NULL,
    [FieldValue]     UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_tblIndexGuid] PRIMARY KEY CLUSTERED ([pkID] ASC)
);


GO
PRINT N'Creating [dbo].[tblIndexGuid].[Idx_TblIndexGuid_fkItemId]...';


GO
CREATE NONCLUSTERED INDEX [Idx_TblIndexGuid_fkItemId]
    ON [dbo].[tblIndexGuid]([fkItemId] ASC, [fkSchemaItemId] ASC);


GO
PRINT N'Creating [dbo].[tblIndexFloat]...';


GO
CREATE TABLE [dbo].[tblIndexFloat] (
    [pkID]           INT            IDENTITY (1, 1) NOT NULL,
    [fkSchemaItemId] INT            NOT NULL,
    [fkItemId]       NVARCHAR (256) NOT NULL,
    [FieldValue]     FLOAT (53)     NULL,
    CONSTRAINT [PK_tblIndexFloat] PRIMARY KEY CLUSTERED ([pkID] ASC)
);


GO
PRINT N'Creating [dbo].[tblIndexFloat].[Idx_TblIndexFloat_fkItemId]...';


GO
CREATE NONCLUSTERED INDEX [Idx_TblIndexFloat_fkItemId]
    ON [dbo].[tblIndexFloat]([fkItemId] ASC, [fkSchemaItemId] ASC);


GO
PRINT N'Creating [dbo].[tblIndexDecimal]...';


GO
CREATE TABLE [dbo].[tblIndexDecimal] (
    [pkID]           INT            IDENTITY (1, 1) NOT NULL,
    [fkSchemaItemId] INT            NOT NULL,
    [fkItemId]       NVARCHAR (256) NOT NULL,
    [FieldValue]     DECIMAL (18)   NULL,
    CONSTRAINT [PK_tblIndexDecimal] PRIMARY KEY CLUSTERED ([pkID] ASC)
);


GO
PRINT N'Creating [dbo].[tblIndexDecimal].[Idx_TblIndexDecimal_fkItemId]...';


GO
CREATE NONCLUSTERED INDEX [Idx_TblIndexDecimal_fkItemId]
    ON [dbo].[tblIndexDecimal]([fkItemId] ASC, [fkSchemaItemId] ASC);


GO
PRINT N'Creating [dbo].[tblIndexDateTime]...';


GO
CREATE TABLE [dbo].[tblIndexDateTime] (
    [pkID]           INT            IDENTITY (1, 1) NOT NULL,
    [fkSchemaItemId] INT            NOT NULL,
    [fkItemId]       NVARCHAR (256) NOT NULL,
    [FieldValue]     DATETIME       NULL,
    CONSTRAINT [PK_tblIndexDateTime] PRIMARY KEY CLUSTERED ([pkID] ASC)
);


GO
PRINT N'Creating [dbo].[tblIndexDateTime].[Idx_TblIndexDataTime_fkItemId]...';


GO
CREATE NONCLUSTERED INDEX [Idx_TblIndexDataTime_fkItemId]
    ON [dbo].[tblIndexDateTime]([fkItemId] ASC, [fkSchemaItemId] ASC);


GO
PRINT N'Creating [dbo].[tblIndexBigInt]...';


GO
CREATE TABLE [dbo].[tblIndexBigInt] (
    [pkID]           INT            IDENTITY (1, 1) NOT NULL,
    [fkSchemaItemId] INT            NOT NULL,
    [fkItemId]       NVARCHAR (256) NOT NULL,
    [FieldValue]     BIGINT         NULL,
    CONSTRAINT [PK_tblIndexBigInt] PRIMARY KEY CLUSTERED ([pkID] ASC)
);


GO
PRINT N'Creating [dbo].[tblIndexInt]...';


GO
CREATE TABLE [dbo].[tblIndexInt] (
    [pkID]           INT            IDENTITY (1, 1) NOT NULL,
    [fkSchemaItemId] INT            NOT NULL,
    [fkItemId]       NVARCHAR (256) NOT NULL,
    [FieldValue]     INT            NULL,
    CONSTRAINT [PK_tblIndexInt] PRIMARY KEY CLUSTERED ([pkID] ASC)
);


GO
PRINT N'Creating [dbo].[tblIndexInt].[Idx_TblIndexInt_fkItemId]...';


GO
CREATE NONCLUSTERED INDEX [Idx_TblIndexInt_fkItemId]
    ON [dbo].[tblIndexInt]([fkItemId] ASC, [fkSchemaItemId] ASC);


GO
PRINT N'Creating [dbo].[tblIndexString]...';


GO
CREATE TABLE [dbo].[tblIndexString] (
    [pkID]           INT            IDENTITY (1, 1) NOT NULL,
    [fkSchemaItemId] INT            NOT NULL,
    [fkItemId]       NVARCHAR (256) NOT NULL,
    [FieldValue]     NVARCHAR (512) NULL,
    CONSTRAINT [PK_tblIndexString] PRIMARY KEY CLUSTERED ([pkID] ASC)
);


GO
PRINT N'Creating [dbo].[tblIndexString].[Idx_TblIndexString_fkItemId]...';


GO
CREATE NONCLUSTERED INDEX [Idx_TblIndexString_fkItemId]
    ON [dbo].[tblIndexString]([fkItemId] ASC, [fkSchemaItemId] ASC);


GO
PRINT N'Creating [dbo].[tblSchemaItem]...';


GO
CREATE TABLE [dbo].[tblSchemaItem] (
    [pkID]       INT            IDENTITY (1, 1) NOT NULL,
    [fkSchemaId] INT            NOT NULL,
    [FieldName]  NVARCHAR (256) NOT NULL,
    [FieldType]  NVARCHAR (256) NOT NULL,
    [Indexed]    INT            NOT NULL,
    CONSTRAINT [PK_tblSchemaItem] PRIMARY KEY CLUSTERED ([pkID] ASC)
);


GO
PRINT N'Creating [dbo].[tblSchema]...';


GO
CREATE TABLE [dbo].[tblSchema] (
    [pkID]     INT            IDENTITY (1, 1) NOT NULL,
    [SchemaId] NVARCHAR (256) NOT NULL,
    [IdType]   NVARCHAR (256) NOT NULL,
    CONSTRAINT [PK_tblSchema] PRIMARY KEY CLUSTERED ([pkID] ASC),
    CONSTRAINT [IX_tblSchema_SchemaId] UNIQUE NONCLUSTERED ([SchemaId] ASC)
);


GO
PRINT N'Creating [dbo].[tblItem]...';


GO
CREATE TABLE [dbo].[tblItem] (
    [pkID]       NVARCHAR (100) NOT NULL,
    [fkSchemaId] INT            NOT NULL,
    [Name]       NVARCHAR (256) NULL,
    [ItemData]   IMAGE          NULL,
    CONSTRAINT [PK_tblItem] PRIMARY KEY CLUSTERED ([pkID] ASC)
);


GO
PRINT N'Creating [dbo].[tblItem].[IX_tblItem_Name]...';


GO
CREATE NONCLUSTERED INDEX [IX_tblItem_Name]
    ON [dbo].[tblItem]([Name] ASC);


GO
PRINT N'Creating [dbo].[tblUnifiedPathProperty]...';


GO
CREATE TABLE [dbo].[tblUnifiedPathProperty] (
    [pkID]            INT             IDENTITY (1, 1) NOT NULL,
    [fkUnifiedPathID] INT             NOT NULL,
    [KeyName]         NVARCHAR (255)  NOT NULL,
    [StringValue]     NVARCHAR (2000) NOT NULL,
    CONSTRAINT [PK_tblUnifiedPathProperty] PRIMARY KEY CLUSTERED ([pkID] ASC)
);


GO
PRINT N'Creating [dbo].[tblUnifiedPathAcl]...';


GO
CREATE TABLE [dbo].[tblUnifiedPathAcl] (
    [pkID]            INT            IDENTITY (1, 1) NOT NULL,
    [fkUnifiedPathID] INT            NOT NULL,
    [Name]            NVARCHAR (255) NOT NULL,
    [IsRole]          INT            NOT NULL,
    [AccessMask]      INT            NOT NULL,
    CONSTRAINT [PK_tblUnifiedPathAcl] PRIMARY KEY CLUSTERED ([pkID] ASC)
);


GO
PRINT N'Creating [dbo].[tblUnifiedPath]...';


GO
CREATE TABLE [dbo].[tblUnifiedPath] (
    [pkID]       INT             IDENTITY (1, 1) NOT NULL,
    [Path]       NVARCHAR (4000) NOT NULL,
    [InheritAcl] BIT             NOT NULL,
    CONSTRAINT [PK_tblUnifiedPath] PRIMARY KEY CLUSTERED ([pkID] ASC)
);


GO
PRINT N'Creating [dbo].[tblWorkContentProperty]...';


GO
CREATE TABLE [dbo].[tblWorkContentProperty] (
    [pkID]                   INT              IDENTITY (1, 1) NOT NULL,
    [fkPropertyDefinitionID] INT              NOT NULL,
    [fkWorkContentID]        INT              NOT NULL,
    [ScopeName]              NVARCHAR (450)   NULL,
    [guid]                   UNIQUEIDENTIFIER NOT NULL,
    [Boolean]                BIT              NOT NULL,
    [Number]                 INT              NULL,
    [FloatNumber]            FLOAT (53)       NULL,
    [ContentType]            INT              NULL,
    [ContentLink]            INT              NULL,
    [Date]                   DATETIME         NULL,
    [String]                 NVARCHAR (450)   NULL,
    [LongString]             NVARCHAR (MAX)   NULL,
    [LinkGuid]               UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_tblWorkProperty] PRIMARY KEY NONCLUSTERED ([pkID] ASC)
);


GO
PRINT N'Creating [dbo].[tblWorkContentProperty].[IX_tblWorkContentProperty_fkWorkContentID]...';


GO
CREATE CLUSTERED INDEX [IX_tblWorkContentProperty_fkWorkContentID]
    ON [dbo].[tblWorkContentProperty]([fkWorkContentID] ASC);


GO
PRINT N'Creating [dbo].[tblWorkContentProperty].[IDX_tblWorkContentProperty_ContentLink]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblWorkContentProperty_ContentLink]
    ON [dbo].[tblWorkContentProperty]([ContentLink] ASC);


GO
PRINT N'Creating [dbo].[tblWorkContentProperty].[IDX_tblWorkContentProperty_ScopeName]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblWorkContentProperty_ScopeName]
    ON [dbo].[tblWorkContentProperty]([ScopeName] ASC);


GO
PRINT N'Creating [dbo].[tblWorkContentProperty].[IDX_tblWorkContentProperty_ContentTypeID]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblWorkContentProperty_ContentTypeID]
    ON [dbo].[tblWorkContentProperty]([ContentType] ASC);


GO
PRINT N'Creating [dbo].[tblWorkContentProperty].[IDX_tblWorkContentProperty_fkPropertyDefinitionID]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblWorkContentProperty_fkPropertyDefinitionID]
    ON [dbo].[tblWorkContentProperty]([fkPropertyDefinitionID] ASC);


GO
PRINT N'Creating [dbo].[tblWorkContentProperty].[IX_tblWorkContentProperty_guid]...';


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_tblWorkContentProperty_guid]
    ON [dbo].[tblWorkContentProperty]([guid] ASC);


GO
PRINT N'Creating [dbo].[tblWorkContent]...';


GO
CREATE TABLE [dbo].[tblWorkContent] (
    [pkID]               INT              IDENTITY (1, 1) NOT NULL,
    [fkContentID]        INT              NOT NULL,
    [fkMasterVersionID]  INT              NULL,
    [ContentLinkGUID]    UNIQUEIDENTIFIER NULL,
    [fkFrameID]          INT              NULL,
    [ArchiveContentGUID] UNIQUEIDENTIFIER NULL,
    [ChangedByName]      NVARCHAR (255)   NOT NULL,
    [NewStatusByName]    NVARCHAR (255)   NULL,
    [Name]               NVARCHAR (255)   NULL,
    [URLSegment]         NVARCHAR (255)   NULL,
    [LinkURL]            NVARCHAR (255)   NULL,
    [BlobUri]            NVARCHAR (255)   NULL,
    [ThumbnailUri]       NVARCHAR (255)   NULL,
    [ExternalURL]        NVARCHAR (255)   NULL,
    [VisibleInMenu]      BIT              NOT NULL,
    [LinkType]           INT              NOT NULL,
    [Created]            DATETIME         NOT NULL,
    [Saved]              DATETIME         NOT NULL,
    [StartPublish]       DATETIME         NULL,
    [StopPublish]        DATETIME         NULL,
    [ChildOrderRule]     INT              NOT NULL,
    [PeerOrder]          INT              NOT NULL,
    [ChangedOnPublish]   BIT              NOT NULL,
    [RejectComment]      NVARCHAR (2000)  NULL,
    [fkLanguageBranchID] INT              NOT NULL,
    [CommonDraft]        BIT              NOT NULL,
    [Status]             INT              NOT NULL,
    [DelayPublishUntil]  DATETIME         NULL,
    CONSTRAINT [PK_tblWorkContent] PRIMARY KEY CLUSTERED ([pkID] ASC)
);


GO
PRINT N'Creating [dbo].[tblWorkContent].[IDX_tblWorkContent_fkContentID]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblWorkContent_fkContentID]
    ON [dbo].[tblWorkContent]([fkContentID] ASC);


GO
PRINT N'Creating [dbo].[tblWorkContent].[IDX_tblWorkContent_ChangedByName]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblWorkContent_ChangedByName]
    ON [dbo].[tblWorkContent]([ChangedByName] ASC);


GO
PRINT N'Creating [dbo].[tblWorkContent].[IDX_tblWorkContent_StatusFields]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblWorkContent_StatusFields]
    ON [dbo].[tblWorkContent]([Status] ASC);


GO
PRINT N'Creating [dbo].[tblWorkContent].[IDX_tblWorkContent_ArchiveContentGUID]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblWorkContent_ArchiveContentGUID]
    ON [dbo].[tblWorkContent]([ArchiveContentGUID] ASC);


GO
PRINT N'Creating [dbo].[tblWorkContent].[IDX_tblWorkContent_ContentLinkGUID]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblWorkContent_ContentLinkGUID]
    ON [dbo].[tblWorkContent]([ContentLinkGUID] ASC);


GO
PRINT N'Creating [dbo].[tblWorkContent].[IDX_tblWorkContent_fkMasterVersionID]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblWorkContent_fkMasterVersionID]
    ON [dbo].[tblWorkContent]([fkMasterVersionID] ASC);


GO
PRINT N'Creating [dbo].[tblWorkContentCategory]...';


GO
CREATE TABLE [dbo].[tblWorkContentCategory] (
    [pkID]            INT            IDENTITY (1, 1) NOT NULL,
    [fkWorkContentID] INT            NOT NULL,
    [fkCategoryID]    INT            NOT NULL,
    [CategoryType]    INT            NOT NULL,
    [ScopeName]       NVARCHAR (450) NOT NULL,
    CONSTRAINT [PK_tblWorkContentCategory] PRIMARY KEY NONCLUSTERED ([pkID] ASC)
);


GO
PRINT N'Creating [dbo].[tblWorkContentCategory].[IDX_tblWorkContentCategory_fkWorkContentID]...';


GO
CREATE CLUSTERED INDEX [IDX_tblWorkContentCategory_fkWorkContentID]
    ON [dbo].[tblWorkContentCategory]([fkWorkContentID] ASC, [CategoryType] ASC);


GO
PRINT N'Creating [dbo].[tblTree]...';


GO
CREATE TABLE [dbo].[tblTree] (
    [fkParentID]   INT      NOT NULL,
    [fkChildID]    INT      NOT NULL,
    [NestingLevel] SMALLINT NOT NULL,
    CONSTRAINT [PK_tblTree] PRIMARY KEY CLUSTERED ([fkParentID] ASC, [fkChildID] ASC)
);


GO
PRINT N'Creating [dbo].[tblTree].[IDX_tblTree_fkChildID]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblTree_fkChildID]
    ON [dbo].[tblTree]([fkChildID] ASC);


GO
PRINT N'Creating [dbo].[tblTask]...';


GO
CREATE TABLE [dbo].[tblTask] (
    [pkID]               INT             IDENTITY (1, 1) NOT NULL,
    [Subject]            NVARCHAR (255)  NOT NULL,
    [Description]        NVARCHAR (2000) NULL,
    [DueDate]            DATETIME        NULL,
    [OwnerName]          NVARCHAR (255)  NOT NULL,
    [AssignedToName]     NVARCHAR (255)  NOT NULL,
    [AssignedIsRole]     BIT             NOT NULL,
    [fkPlugInID]         INT             NULL,
    [Status]             INT             NOT NULL,
    [Activity]           NVARCHAR (MAX)  NULL,
    [State]              NVARCHAR (MAX)  NULL,
    [Created]            DATETIME        NOT NULL,
    [Changed]            DATETIME        NOT NULL,
    [WorkflowInstanceId] NVARCHAR (36)   NULL,
    [EventActivityName]  NVARCHAR (255)  NULL,
    CONSTRAINT [PK_tblTask] PRIMARY KEY CLUSTERED ([pkID] ASC)
);


GO
PRINT N'Creating [dbo].[tblScheduledItemLog]...';


GO
CREATE TABLE [dbo].[tblScheduledItemLog] (
    [pkID]              INT              IDENTITY (1, 1) NOT NULL,
    [fkScheduledItemId] UNIQUEIDENTIFIER NOT NULL,
    [Exec]              DATETIME         NOT NULL,
    [Status]            INT              NULL,
    [Text]              NVARCHAR (2048)  NULL,
    CONSTRAINT [PK_tblScheduledItemLog] PRIMARY KEY CLUSTERED ([pkID] ASC)
);


GO
PRINT N'Creating [dbo].[tblScheduledItem]...';


GO
CREATE TABLE [dbo].[tblScheduledItem] (
    [pkID]                 UNIQUEIDENTIFIER NOT NULL,
    [Name]                 NVARCHAR (50)    NULL,
    [Enabled]              BIT              NOT NULL,
    [LastExec]             DATETIME         NULL,
    [LastStatus]           INT              NULL,
    [LastText]             NVARCHAR (2048)  NULL,
    [NextExec]             DATETIME         NULL,
    [DatePart]             NCHAR (2)        NULL,
    [Interval]             INT              NULL,
    [MethodName]           NVARCHAR (100)   NOT NULL,
    [fStatic]              BIT              NOT NULL,
    [TypeName]             NVARCHAR (1024)  NOT NULL,
    [AssemblyName]         NVARCHAR (100)   NOT NULL,
    [InstanceData]         IMAGE            NULL,
    [IsRunning]            BIT              NOT NULL,
    [CurrentStatusMessage] NVARCHAR (2048)  NULL,
    [LastPing]             DATETIME         NULL,
    CONSTRAINT [PK__tblScheduledItem__1940BAED] PRIMARY KEY CLUSTERED ([pkID] ASC)
);


GO
PRINT N'Creating [dbo].[tblRemoteSite]...';


GO
CREATE TABLE [dbo].[tblRemoteSite] (
    [pkID]           INT            IDENTITY (1, 1) NOT NULL,
    [Name]           NVARCHAR (100) NOT NULL,
    [Url]            NVARCHAR (255) NOT NULL,
    [IsTrusted]      BIT            NOT NULL,
    [UserName]       NVARCHAR (50)  NULL,
    [Password]       NVARCHAR (50)  NULL,
    [Domain]         NVARCHAR (50)  NULL,
    [AllowUrlLookup] BIT            NOT NULL,
    CONSTRAINT [PK_tblRemoteSite] PRIMARY KEY CLUSTERED ([pkID] ASC),
    CONSTRAINT [IX_tblRemoteSite] UNIQUE NONCLUSTERED ([Name] ASC)
);


GO
PRINT N'Creating [dbo].[tblPropertyDefinitionDefault]...';


GO
CREATE TABLE [dbo].[tblPropertyDefinitionDefault] (
    [pkID]                   INT              IDENTITY (1, 1) NOT NULL,
    [fkPropertyDefinitionID] INT              NOT NULL,
    [Boolean]                BIT              NOT NULL,
    [Number]                 INT              NULL,
    [FloatNumber]            FLOAT (53)       NULL,
    [ContentType]            INT              NULL,
    [ContentLink]            INT              NULL,
    [Date]                   DATETIME         NULL,
    [String]                 NVARCHAR (450)   NULL,
    [LongString]             NVARCHAR (MAX)   NULL,
    [LinkGuid]               UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_tblPropertyDefinitionDefault] PRIMARY KEY CLUSTERED ([pkID] ASC)
);


GO
PRINT N'Creating [dbo].[tblContentProperty]...';


GO
CREATE TABLE [dbo].[tblContentProperty] (
    [pkID]                   INT              IDENTITY (1, 1) NOT NULL,
    [fkPropertyDefinitionID] INT              NOT NULL,
    [fkContentID]            INT              NOT NULL,
    [fkLanguageBranchID]     INT              NOT NULL,
    [ScopeName]              NVARCHAR (450)   NULL,
    [guid]                   UNIQUEIDENTIFIER NOT NULL,
    [Boolean]                BIT              NOT NULL,
    [Number]                 INT              NULL,
    [FloatNumber]            FLOAT (53)       NULL,
    [ContentType]            INT              NULL,
    [ContentLink]            INT              NULL,
    [Date]                   DATETIME         NULL,
    [String]                 NVARCHAR (450)   NULL,
    [LongString]             NVARCHAR (MAX)   NULL,
    [LongStringLength]       INT              NULL,
    [LinkGuid]               UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_tblContentProperty] PRIMARY KEY NONCLUSTERED ([pkID] ASC)
);


GO
PRINT N'Creating [dbo].[tblContentProperty].[IDX_tblContentProperty_fkContentID]...';


GO
CREATE CLUSTERED INDEX [IDX_tblContentProperty_fkContentID]
    ON [dbo].[tblContentProperty]([fkContentID] ASC, [fkLanguageBranchID] ASC, [fkPropertyDefinitionID] ASC);


GO
PRINT N'Creating [dbo].[tblContentProperty].[IDX_tblContentProperty_fkPropertyDefinitionID]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblContentProperty_fkPropertyDefinitionID]
    ON [dbo].[tblContentProperty]([fkPropertyDefinitionID] ASC);


GO
PRINT N'Creating [dbo].[tblContentProperty].[IDX_tblContentProperty_ScopeName]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblContentProperty_ScopeName]
    ON [dbo].[tblContentProperty]([ScopeName] ASC);


GO
PRINT N'Creating [dbo].[tblContentProperty].[IDX_tblContentProperty_ContentLink]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblContentProperty_ContentLink]
    ON [dbo].[tblContentProperty]([ContentLink] ASC, [LinkGuid] ASC)
    INCLUDE([fkPropertyDefinitionID], [fkContentID], [fkLanguageBranchID]);


GO
PRINT N'Creating [dbo].[tblContentProperty].[IDX_tblContentProperty_ContentTypeID]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblContentProperty_ContentTypeID]
    ON [dbo].[tblContentProperty]([ContentType] ASC);


GO
PRINT N'Creating [dbo].[tblContentProperty].[IX_tblContentProperty_guid]...';


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_tblContentProperty_guid]
    ON [dbo].[tblContentProperty]([guid] ASC);


GO
PRINT N'Creating [dbo].[tblPlugIn]...';


GO
CREATE TABLE [dbo].[tblPlugIn] (
    [pkID]         INT            IDENTITY (1, 1) NOT NULL,
    [AssemblyName] NVARCHAR (255) NOT NULL,
    [TypeName]     NVARCHAR (255) NOT NULL,
    [Settings]     NVARCHAR (MAX) NULL,
    [Saved]        DATETIME       NOT NULL,
    [Created]      DATETIME       NOT NULL,
    [Enabled]      BIT            NOT NULL,
    CONSTRAINT [PK_tblPlugIn] PRIMARY KEY CLUSTERED ([pkID] ASC)
);


GO
PRINT N'Creating [dbo].[tblUserPermission]...';


GO
CREATE TABLE [dbo].[tblUserPermission] (
    [Name]       NVARCHAR (255) NOT NULL,
    [IsRole]     INT            NOT NULL,
    [Permission] INT            NOT NULL,
    CONSTRAINT [PK_tblUserPermission] PRIMARY KEY CLUSTERED ([Name] ASC, [IsRole] ASC, [Permission] ASC)
);


GO
PRINT N'Creating [dbo].[tblContentTypeToContentType]...';


GO
CREATE TABLE [dbo].[tblContentTypeToContentType] (
    [fkContentTypeParentID] INT NOT NULL,
    [fkContentTypeChildID]  INT NOT NULL,
    [Access]                INT NOT NULL,
    [Availability]          INT NOT NULL,
    [Allow]                 BIT NULL,
    CONSTRAINT [PK_tblContentTypeToContentType] PRIMARY KEY CLUSTERED ([fkContentTypeParentID] ASC, [fkContentTypeChildID] ASC)
);


GO
PRINT N'Creating [dbo].[tblContentTypeDefault]...';


GO
CREATE TABLE [dbo].[tblContentTypeDefault] (
    [pkID]                    INT            IDENTITY (1, 1) NOT NULL,
    [fkContentTypeID]         INT            NOT NULL,
    [fkContentLinkID]         INT            NULL,
    [fkFrameID]               INT            NULL,
    [fkArchiveContentID]      INT            NULL,
    [Name]                    NVARCHAR (255) NULL,
    [VisibleInMenu]           BIT            NOT NULL,
    [StartPublishOffsetValue] INT            NULL,
    [StartPublishOffsetType]  NCHAR (1)      NULL,
    [StopPublishOffsetValue]  INT            NULL,
    [StopPublishOffsetType]   NCHAR (1)      NULL,
    [ChildOrderRule]          INT            NOT NULL,
    [PeerOrder]               INT            NOT NULL,
    [StartPublishOffset]      INT            NULL,
    [StopPublishOffset]       INT            NULL,
    CONSTRAINT [PK_tblContentTypeDefault] PRIMARY KEY CLUSTERED ([pkID] ASC)
);


GO
PRINT N'Creating [dbo].[tblContentType]...';


GO
CREATE TABLE [dbo].[tblContentType] (
    [pkID]                   INT              IDENTITY (1, 1) NOT NULL,
    [ContentTypeGUID]        UNIQUEIDENTIFIER NOT NULL,
    [Created]                DATETIME         NOT NULL,
    [DefaultWebFormTemplate] NVARCHAR (1024)  NULL,
    [DefaultMvcController]   NVARCHAR (1024)  NULL,
    [DefaultMvcPartialView]  NVARCHAR (255)   NULL,
    [Filename]               NVARCHAR (255)   NULL,
    [ModelType]              NVARCHAR (1024)  NULL,
    [Name]                   NVARCHAR (50)    NOT NULL,
    [DisplayName]            NVARCHAR (50)    NULL,
    [Description]            NVARCHAR (255)   NULL,
    [IdString]               NVARCHAR (50)    NULL,
    [Available]              BIT              NULL,
    [SortOrder]              INT              NULL,
    [MetaDataInherit]        INT              NOT NULL,
    [MetaDataDefault]        INT              NOT NULL,
    [WorkflowEditFields]     BIT              NULL,
    [ACL]                    NVARCHAR (MAX)   NULL,
    [ContentType]            INT              NOT NULL,
    CONSTRAINT [PK_tblContentType] PRIMARY KEY CLUSTERED ([pkID] ASC)
);


GO
PRINT N'Creating [dbo].[tblContentSoftlink]...';


GO
CREATE TABLE [dbo].[tblContentSoftlink] (
    [pkID]                    INT              IDENTITY (1, 1) NOT NULL,
    [fkOwnerContentID]        INT              NOT NULL,
    [fkReferencedContentGUID] UNIQUEIDENTIFIER NULL,
    [OwnerLanguageID]         INT              NULL,
    [ReferencedLanguageID]    INT              NULL,
    [LinkURL]                 NVARCHAR (255)   NOT NULL,
    [LinkType]                INT              NOT NULL,
    [LinkProtocol]            NVARCHAR (10)    NULL,
    [ContentLink]             NVARCHAR (255)   NULL,
    [LastCheckedDate]         DATETIME         NULL,
    [FirstDateBroken]         DATETIME         NULL,
    [HttpStatusCode]          INT              NULL,
    [LinkStatus]              INT              NULL,
    CONSTRAINT [PK_tblContentSoftlink] PRIMARY KEY CLUSTERED ([pkID] ASC)
);


GO
PRINT N'Creating [dbo].[tblContentSoftlink].[IDX_tblContentSoftlink_fkContentID]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblContentSoftlink_fkContentID]
    ON [dbo].[tblContentSoftlink]([fkOwnerContentID] ASC);


GO
PRINT N'Creating [dbo].[tblContentSoftlink].[IDX_tblContentSoftlink_fkReferencedContentGUID]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblContentSoftlink_fkReferencedContentGUID]
    ON [dbo].[tblContentSoftlink]([fkReferencedContentGUID] ASC);


GO
PRINT N'Creating [dbo].[tblPropertyDefinitionType]...';


GO
CREATE TABLE [dbo].[tblPropertyDefinitionType] (
    [pkID]              INT              NOT NULL,
    [Property]          INT              NOT NULL,
    [Name]              NVARCHAR (255)   NOT NULL,
    [TypeName]          NVARCHAR (255)   NULL,
    [AssemblyName]      NVARCHAR (255)   NULL,
    [fkContentTypeGUID] UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_tblPropertyDefinitionType] PRIMARY KEY CLUSTERED ([pkID] ASC)
);


GO
PRINT N'Creating [dbo].[tblPropertyDefinitionGroup]...';


GO
CREATE TABLE [dbo].[tblPropertyDefinitionGroup] (
    [pkID]         INT            IDENTITY (100, 1) NOT NULL,
    [SystemGroup]  BIT            NOT NULL,
    [Access]       INT            NOT NULL,
    [GroupVisible] BIT            NOT NULL,
    [GroupOrder]   INT            NOT NULL,
    [Name]         NVARCHAR (100) NULL,
    [DisplayName]  NVARCHAR (100) NULL,
    CONSTRAINT [PK_tblPropertyDefinitionGroup] PRIMARY KEY CLUSTERED ([pkID] ASC)
);


GO
PRINT N'Creating [dbo].[tblPropertyDefinition]...';


GO
CREATE TABLE [dbo].[tblPropertyDefinition] (
    [pkID]                       INT              IDENTITY (1, 1) NOT NULL,
    [fkContentTypeID]            INT              NULL,
    [fkPropertyDefinitionTypeID] INT              NULL,
    [FieldOrder]                 INT              NULL,
    [Name]                       NVARCHAR (50)    NOT NULL,
    [Property]                   INT              NOT NULL,
    [Required]                   BIT              NULL,
    [Advanced]                   INT              NULL,
    [Searchable]                 BIT              NULL,
    [EditCaption]                NVARCHAR (255)   NULL,
    [HelpText]                   NVARCHAR (2000)  NULL,
    [ObjectProgID]               NVARCHAR (255)   NULL,
    [DefaultValueType]           INT              NOT NULL,
    [LongStringSettings]         INT              NOT NULL,
    [SettingsID]                 UNIQUEIDENTIFIER NULL,
    [LanguageSpecific]           INT              NOT NULL,
    [DisplayEditUI]              BIT              NULL,
    [ExistsOnModel]              BIT              NOT NULL,
    CONSTRAINT [PK_tblPropertyDefinition] PRIMARY KEY CLUSTERED ([pkID] ASC)
);


GO
PRINT N'Creating [dbo].[tblPropertyDefinition].[IDX_tblPropertyDefinition_fkContentTypeID]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblPropertyDefinition_fkContentTypeID]
    ON [dbo].[tblPropertyDefinition]([fkContentTypeID] ASC);


GO
PRINT N'Creating [dbo].[tblPropertyDefinition].[IDX_tblPropertyDefinition_Name]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblPropertyDefinition_Name]
    ON [dbo].[tblPropertyDefinition]([Name] ASC);


GO
PRINT N'Creating [dbo].[tblPropertyDefinition].[IDX_tblPropertyDefinition_fkPropertyDefinitionTypeID]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblPropertyDefinition_fkPropertyDefinitionTypeID]
    ON [dbo].[tblPropertyDefinition]([fkPropertyDefinitionTypeID] ASC);


GO
PRINT N'Creating [dbo].[tblContent]...';


GO
CREATE TABLE [dbo].[tblContent] (
    [pkID]                     INT              IDENTITY (1, 1) NOT NULL,
    [fkContentTypeID]          INT              NOT NULL,
    [fkParentID]               INT              NULL,
    [ArchiveContentGUID]       UNIQUEIDENTIFIER NULL,
    [CreatorName]              NVARCHAR (255)   NULL,
    [ContentGUID]              UNIQUEIDENTIFIER NOT NULL,
    [VisibleInMenu]            BIT              NOT NULL,
    [Deleted]                  BIT              NOT NULL,
    [ChildOrderRule]           INT              NOT NULL,
    [PeerOrder]                INT              NOT NULL,
    [ExternalFolderID]         INT              NULL,
    [ContentAssetsID]          UNIQUEIDENTIFIER NULL,
    [ContentOwnerID]           UNIQUEIDENTIFIER NULL,
    [DeletedBy]                NVARCHAR (255)   NULL,
    [DeletedDate]              DATETIME         NULL,
    [fkMasterLanguageBranchID] INT              NOT NULL,
    [ContentPath]              VARCHAR (900)    NOT NULL,
    [ContentType]              INT              NOT NULL,
    [IsLeafNode]               BIT              NOT NULL,
    CONSTRAINT [PK_tblContent] PRIMARY KEY CLUSTERED ([pkID] ASC)
);


GO
PRINT N'Creating [dbo].[tblContent].[IDX_tblContent_fkParentID]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblContent_fkParentID]
    ON [dbo].[tblContent]([fkParentID] ASC);


GO
PRINT N'Creating [dbo].[tblContent].[IDX_tblContent_ContentGUID]...';


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_tblContent_ContentGUID]
    ON [dbo].[tblContent]([ContentGUID] ASC);


GO
PRINT N'Creating [dbo].[tblContent].[IDX_tblContent_ContentType]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblContent_ContentType]
    ON [dbo].[tblContent]([ContentType] ASC);


GO
PRINT N'Creating [dbo].[tblContent].[IDX_tblContent_ArchiveContentGUID]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblContent_ArchiveContentGUID]
    ON [dbo].[tblContent]([ArchiveContentGUID] ASC);


GO
PRINT N'Creating [dbo].[tblContent].[IDX_tblContent_ContentPath]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblContent_ContentPath]
    ON [dbo].[tblContent]([ContentPath] ASC);


GO
PRINT N'Creating [dbo].[tblContent].[IDX_tblContent_fkContentTypeID]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblContent_fkContentTypeID]
    ON [dbo].[tblContent]([fkContentTypeID] ASC);


GO
PRINT N'Creating [dbo].[tblContent].[IDX_tblContent_ExternalFolderID]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblContent_ExternalFolderID]
    ON [dbo].[tblContent]([ExternalFolderID] ASC);


GO
PRINT N'Creating [dbo].[tblFrame]...';


GO
CREATE TABLE [dbo].[tblFrame] (
    [pkID]             INT            IDENTITY (1, 1) NOT NULL,
    [FrameName]        NVARCHAR (100) NOT NULL,
    [FrameDescription] NVARCHAR (255) NULL,
    [SystemFrame]      BIT            NOT NULL,
    CONSTRAINT [PK_tblFrame] PRIMARY KEY CLUSTERED ([pkID] ASC)
);


GO
PRINT N'Creating [dbo].[tblContentCategory]...';


GO
CREATE TABLE [dbo].[tblContentCategory] (
    [pkID]               INT            IDENTITY (1, 1) NOT NULL,
    [fkContentID]        INT            NOT NULL,
    [fkCategoryID]       INT            NOT NULL,
    [CategoryType]       INT            NOT NULL,
    [fkLanguageBranchID] INT            NOT NULL,
    [ScopeName]          NVARCHAR (450) NOT NULL,
    CONSTRAINT [PK_tblContentCategory] PRIMARY KEY NONCLUSTERED ([pkID] ASC)
);


GO
PRINT N'Creating [dbo].[tblContentCategory].[IDX_tblContentCategory_fkContentID]...';


GO
CREATE CLUSTERED INDEX [IDX_tblContentCategory_fkContentID]
    ON [dbo].[tblContentCategory]([fkContentID] ASC, [CategoryType] ASC);


GO
PRINT N'Creating [dbo].[tblContentCategory].[IDX_tblContentCategory_fkCategoryID]...';


GO
CREATE NONCLUSTERED INDEX [IDX_tblContentCategory_fkCategoryID]
    ON [dbo].[tblContentCategory]([fkCategoryID] ASC)
    INCLUDE([fkContentID], [CategoryType], [fkLanguageBranchID]);


GO
PRINT N'Creating [dbo].[tblCategory]...';


GO
CREATE TABLE [dbo].[tblCategory] (
    [pkID]                INT              IDENTITY (1, 1) NOT NULL,
    [fkParentID]          INT              NULL,
    [CategoryGUID]        UNIQUEIDENTIFIER NOT NULL,
    [SortOrder]           INT              NOT NULL,
    [Available]           BIT              NOT NULL,
    [Selectable]          BIT              NOT NULL,
    [SuperCategory]       BIT              NOT NULL,
    [CategoryName]        NVARCHAR (50)    NOT NULL,
    [CategoryDescription] NVARCHAR (255)   NULL,
    CONSTRAINT [PK_tblCategory] PRIMARY KEY CLUSTERED ([pkID] ASC)
);


GO
PRINT N'Creating [dbo].[tblContentAccess]...';


GO
CREATE TABLE [dbo].[tblContentAccess] (
    [fkContentID] INT            NOT NULL,
    [Name]        NVARCHAR (255) NOT NULL,
    [IsRole]      INT            NOT NULL,
    [AccessMask]  INT            NOT NULL,
    CONSTRAINT [PK_tblContentAccess] PRIMARY KEY CLUSTERED ([fkContentID] ASC, [Name] ASC)
);


GO
PRINT N'Creating [dbo].[tblAccessType]...';


GO
CREATE TABLE [dbo].[tblAccessType] (
    [pkID] INT           NOT NULL,
    [Name] NVARCHAR (64) NOT NULL,
    CONSTRAINT [PK_tblAccessType] PRIMARY KEY CLUSTERED ([pkID] ASC)
);


GO
PRINT N'Creating DF_tblMappedIdentity_ContentGuid...';


GO
ALTER TABLE [dbo].[tblMappedIdentity]
    ADD CONSTRAINT [DF_tblMappedIdentity_ContentGuid] DEFAULT (NEWID()) FOR [ContentGuid];


GO
PRINT N'Creating tblVisitorGroupStatistic_Row...';


GO
ALTER TABLE [dbo].[tblVisitorGroupStatistic]
    ADD CONSTRAINT [tblVisitorGroupStatistic_Row] DEFAULT (1) FOR [Row];


GO
PRINT N'Creating tblSystemBigTable_Row...';


GO
ALTER TABLE [dbo].[tblSystemBigTable]
    ADD CONSTRAINT [tblSystemBigTable_Row] DEFAULT (1) FOR [Row];


GO
PRINT N'Creating [tblIndexRequestLog_Row...';


GO
ALTER TABLE [dbo].[tblIndexRequestLog]
    ADD CONSTRAINT [[tblIndexRequestLog_Row] DEFAULT (1) FOR [Row];


GO
PRINT N'Creating tblBigTableReference_Index...';


GO
ALTER TABLE [dbo].[tblBigTableReference]
    ADD CONSTRAINT [tblBigTableReference_Index] DEFAULT (1) FOR [Index];


GO
PRINT N'Creating DF_tblBigTableIdentity_Guid...';


GO
ALTER TABLE [dbo].[tblBigTableIdentity]
    ADD CONSTRAINT [DF_tblBigTableIdentity_Guid] DEFAULT (newid()) FOR [Guid];


GO
PRINT N'Creating DF_tblBigTable_Row...';


GO
ALTER TABLE [dbo].[tblBigTable]
    ADD CONSTRAINT [DF_tblBigTable_Row] DEFAULT (1) FOR [Row];


GO
PRINT N'Creating DF_tblXFormData_Row...';


GO
ALTER TABLE [dbo].[tblXFormData]
    ADD CONSTRAINT [DF_tblXFormData_Row] DEFAULT ((1)) FOR [Row];


GO
PRINT N'Creating DF_tblChangeLog_ChangeDate...';


GO
ALTER TABLE [dbo].[tblChangeLog]
    ADD CONSTRAINT [DF_tblChangeLog_ChangeDate] DEFAULT (getdate()) FOR [ChangeDate];


GO
PRINT N'Creating DF_tblChangeLog_Category...';


GO
ALTER TABLE [dbo].[tblChangeLog]
    ADD CONSTRAINT [DF_tblChangeLog_Category] DEFAULT ((0)) FOR [Category];


GO
PRINT N'Creating DF_tblChangeLog_Action...';


GO
ALTER TABLE [dbo].[tblChangeLog]
    ADD CONSTRAINT [DF_tblChangeLog_Action] DEFAULT ((0)) FOR [Action];


GO
PRINT N'Creating Default Constraint on [dbo].[tblWindowsGroup]....';


GO
ALTER TABLE [dbo].[tblWindowsGroup]
    ADD DEFAULT (1) FOR [Enabled];


GO
PRINT N'Creating DF__tblUniqueSequence__LastValue...';


GO
ALTER TABLE [dbo].[tblUniqueSequence]
    ADD CONSTRAINT [DF__tblUniqueSequence__LastValue] DEFAULT (0) FOR [LastValue];


GO
PRINT N'Creating DF__tblLanguageBranch__Enabled...';


GO
ALTER TABLE [dbo].[tblLanguageBranch]
    ADD CONSTRAINT [DF__tblLanguageBranch__Enabled] DEFAULT (1) FOR [Enabled];


GO
PRINT N'Creating DF__tblConten__Activ__51300E55...';


GO
ALTER TABLE [dbo].[tblContentLanguageSetting]
    ADD CONSTRAINT [DF__tblConten__Activ__51300E55] DEFAULT (1) FOR [Active];


GO
PRINT N'Creating DF__tblContentLanguage__ContentGUID...';


GO
ALTER TABLE [dbo].[tblContentLanguage]
    ADD CONSTRAINT [DF__tblContentLanguage__ContentGUID] DEFAULT (newid()) FOR [ContentGUID];


GO
PRINT N'Creating DF__tblContentLanguage__Automatic...';


GO
ALTER TABLE [dbo].[tblContentLanguage]
    ADD CONSTRAINT [DF__tblContentLanguage__Automatic] DEFAULT (1) FOR [AutomaticLink];


GO
PRINT N'Creating DF__tblContentLanguage__FetchData...';


GO
ALTER TABLE [dbo].[tblContentLanguage]
    ADD CONSTRAINT [DF__tblContentLanguage__FetchData] DEFAULT (0) FOR [FetchData];


GO
PRINT N'Creating DF__tblContentLanguage__Created...';


GO
ALTER TABLE [dbo].[tblContentLanguage]
    ADD CONSTRAINT [DF__tblContentLanguage__Created] DEFAULT (getdate()) FOR [Created];


GO
PRINT N'Creating DF__tblContentLanguage__Changed...';


GO
ALTER TABLE [dbo].[tblContentLanguage]
    ADD CONSTRAINT [DF__tblContentLanguage__Changed] DEFAULT (getdate()) FOR [Changed];


GO
PRINT N'Creating DF__tblContentLanguage__Saved...';


GO
ALTER TABLE [dbo].[tblContentLanguage]
    ADD CONSTRAINT [DF__tblContentLanguage__Saved] DEFAULT (getdate()) FOR [Saved];


GO
PRINT N'Creating Default Constraint on [dbo].[tblContentLanguage]....';


GO
ALTER TABLE [dbo].[tblContentLanguage]
    ADD DEFAULT (2) FOR [Status];


GO
PRINT N'Creating DF_tblUnifiedPathAcl_IsRole...';


GO
ALTER TABLE [dbo].[tblUnifiedPathAcl]
    ADD CONSTRAINT [DF_tblUnifiedPathAcl_IsRole] DEFAULT (1) FOR [IsRole];


GO
PRINT N'Creating DF_tblUnifiedPath_InheritAcl...';


GO
ALTER TABLE [dbo].[tblUnifiedPath]
    ADD CONSTRAINT [DF_tblUnifiedPath_InheritAcl] DEFAULT (1) FOR [InheritAcl];


GO
PRINT N'Creating DF__tblWorkContentProperty_guid...';


GO
ALTER TABLE [dbo].[tblWorkContentProperty]
    ADD CONSTRAINT [DF__tblWorkContentProperty_guid] DEFAULT (newid()) FOR [guid];


GO
PRINT N'Creating DF__tblWorkPr__Boole__55209ACA...';


GO
ALTER TABLE [dbo].[tblWorkContentProperty]
    ADD CONSTRAINT [DF__tblWorkPr__Boole__55209ACA] DEFAULT (0) FOR [Boolean];


GO
PRINT N'Creating DF__tblWorkPa__LinkT__48BAC3E5...';


GO
ALTER TABLE [dbo].[tblWorkContent]
    ADD CONSTRAINT [DF__tblWorkPa__LinkT__48BAC3E5] DEFAULT (0) FOR [LinkType];


GO
PRINT N'Creating DF__tblWorkPa__Creat__49AEE81E...';


GO
ALTER TABLE [dbo].[tblWorkContent]
    ADD CONSTRAINT [DF__tblWorkPa__Creat__49AEE81E] DEFAULT (getdate()) FOR [Created];


GO
PRINT N'Creating DF__tblWorkPa__Saved__4AA30C57...';


GO
ALTER TABLE [dbo].[tblWorkContent]
    ADD CONSTRAINT [DF__tblWorkPa__Saved__4AA30C57] DEFAULT (getdate()) FOR [Saved];


GO
PRINT N'Creating DF__tblWorkPa__Child__4B973090...';


GO
ALTER TABLE [dbo].[tblWorkContent]
    ADD CONSTRAINT [DF__tblWorkPa__Child__4B973090] DEFAULT (1) FOR [ChildOrderRule];


GO
PRINT N'Creating DF__tblWorkPa__PeerO__4C8B54C9...';


GO
ALTER TABLE [dbo].[tblWorkContent]
    ADD CONSTRAINT [DF__tblWorkPa__PeerO__4C8B54C9] DEFAULT (100) FOR [PeerOrder];


GO
PRINT N'Creating DF__tblWorkPa__Chang__4E739D3B...';


GO
ALTER TABLE [dbo].[tblWorkContent]
    ADD CONSTRAINT [DF__tblWorkPa__Chang__4E739D3B] DEFAULT (0) FOR [ChangedOnPublish];


GO
PRINT N'Creating DF__tblWorkPa__fkLan__4258C320...';


GO
ALTER TABLE [dbo].[tblWorkContent]
    ADD CONSTRAINT [DF__tblWorkPa__fkLan__4258C320] DEFAULT (1) FOR [fkLanguageBranchID];


GO
PRINT N'Creating DF_tblWorkContent_CommonDraft...';


GO
ALTER TABLE [dbo].[tblWorkContent]
    ADD CONSTRAINT [DF_tblWorkContent_CommonDraft] DEFAULT (0) FOR [CommonDraft];


GO
PRINT N'Creating Default Constraint on [dbo].[tblWorkContent]....';


GO
ALTER TABLE [dbo].[tblWorkContent]
    ADD DEFAULT (2) FOR [Status];


GO
PRINT N'Creating DF_tblWorkContentCategory_CategoryType...';


GO
ALTER TABLE [dbo].[tblWorkContentCategory]
    ADD CONSTRAINT [DF_tblWorkContentCategory_CategoryType] DEFAULT (0) FOR [CategoryType];


GO
PRINT N'Creating DF_tblTask_Status...';


GO
ALTER TABLE [dbo].[tblTask]
    ADD CONSTRAINT [DF_tblTask_Status] DEFAULT (0) FOR [Status];


GO
PRINT N'Creating DF_tblTask_Created...';


GO
ALTER TABLE [dbo].[tblTask]
    ADD CONSTRAINT [DF_tblTask_Created] DEFAULT (getdate()) FOR [Created];


GO
PRINT N'Creating DF_tblTask_Changed...';


GO
ALTER TABLE [dbo].[tblTask]
    ADD CONSTRAINT [DF_tblTask_Changed] DEFAULT (getdate()) FOR [Changed];


GO
PRINT N'Creating DF__tblSchedul__pkID__1A34DF26...';


GO
ALTER TABLE [dbo].[tblScheduledItem]
    ADD CONSTRAINT [DF__tblSchedul__pkID__1A34DF26] DEFAULT (newid()) FOR [pkID];


GO
PRINT N'Creating DF_tblScheduledItem_Enabled...';


GO
ALTER TABLE [dbo].[tblScheduledItem]
    ADD CONSTRAINT [DF_tblScheduledItem_Enabled] DEFAULT (0) FOR [Enabled];


GO
PRINT N'Creating DF__tblScheduledItem__IsRunnning...';


GO
ALTER TABLE [dbo].[tblScheduledItem]
    ADD CONSTRAINT [DF__tblScheduledItem__IsRunnning] DEFAULT (0) FOR [IsRunning];


GO
PRINT N'Creating DF_tblRemoteSite_IsTrusted...';


GO
ALTER TABLE [dbo].[tblRemoteSite]
    ADD CONSTRAINT [DF_tblRemoteSite_IsTrusted] DEFAULT (0) FOR [IsTrusted];


GO
PRINT N'Creating DF_tblRemoteSite_AllowUrlLookup...';


GO
ALTER TABLE [dbo].[tblRemoteSite]
    ADD CONSTRAINT [DF_tblRemoteSite_AllowUrlLookup] DEFAULT (0) FOR [AllowUrlLookup];


GO
PRINT N'Creating DF_tblPropertyDefault_Boolean...';


GO
ALTER TABLE [dbo].[tblPropertyDefinitionDefault]
    ADD CONSTRAINT [DF_tblPropertyDefault_Boolean] DEFAULT (0) FOR [Boolean];


GO
PRINT N'Creating DF__tblProper__fkLan__29B609E9...';


GO
ALTER TABLE [dbo].[tblContentProperty]
    ADD CONSTRAINT [DF__tblProper__fkLan__29B609E9] DEFAULT (1) FOR [fkLanguageBranchID];


GO
PRINT N'Creating DF__tblPropert__guid__43F60EC8...';


GO
ALTER TABLE [dbo].[tblContentProperty]
    ADD CONSTRAINT [DF__tblPropert__guid__43F60EC8] DEFAULT (newid()) FOR [guid];


GO
PRINT N'Creating DF__tblProper__Boole__44EA3301...';


GO
ALTER TABLE [dbo].[tblContentProperty]
    ADD CONSTRAINT [DF__tblProper__Boole__44EA3301] DEFAULT (0) FOR [Boolean];


GO
PRINT N'Creating DF_tblPlugIn_Accessed...';


GO
ALTER TABLE [dbo].[tblPlugIn]
    ADD CONSTRAINT [DF_tblPlugIn_Accessed] DEFAULT (getdate()) FOR [Saved];


GO
PRINT N'Creating DF_tblPlugIn_Created...';


GO
ALTER TABLE [dbo].[tblPlugIn]
    ADD CONSTRAINT [DF_tblPlugIn_Created] DEFAULT (getdate()) FOR [Created];


GO
PRINT N'Creating DF_tblPlugIn_Enabled...';


GO
ALTER TABLE [dbo].[tblPlugIn]
    ADD CONSTRAINT [DF_tblPlugIn_Enabled] DEFAULT (1) FOR [Enabled];


GO
PRINT N'Creating DF_tblUserPermission_IsRole...';


GO
ALTER TABLE [dbo].[tblUserPermission]
    ADD CONSTRAINT [DF_tblUserPermission_IsRole] DEFAULT (1) FOR [IsRole];


GO
PRINT N'Creating DF_tblContentTypeToContentType_Access...';


GO
ALTER TABLE [dbo].[tblContentTypeToContentType]
    ADD CONSTRAINT [DF_tblContentTypeToContentType_Access] DEFAULT (20) FOR [Access];


GO
PRINT N'Creating DF_tblContentTypeToContentType_Availability...';


GO
ALTER TABLE [dbo].[tblContentTypeToContentType]
    ADD CONSTRAINT [DF_tblContentTypeToContentType_Availability] DEFAULT (0) FOR [Availability];


GO
PRINT N'Creating DF_tblContentTypeDefault_VisibleInMenu...';


GO
ALTER TABLE [dbo].[tblContentTypeDefault]
    ADD CONSTRAINT [DF_tblContentTypeDefault_VisibleInMenu] DEFAULT (1) FOR [VisibleInMenu];


GO
PRINT N'Creating DF_tblContentTypeDefault_ChildOrderRule...';


GO
ALTER TABLE [dbo].[tblContentTypeDefault]
    ADD CONSTRAINT [DF_tblContentTypeDefault_ChildOrderRule] DEFAULT (1) FOR [ChildOrderRule];


GO
PRINT N'Creating DF_tblContentTypeDefault_PeerOrder...';


GO
ALTER TABLE [dbo].[tblContentTypeDefault]
    ADD CONSTRAINT [DF_tblContentTypeDefault_PeerOrder] DEFAULT (100) FOR [PeerOrder];


GO
PRINT N'Creating DF_tblContentType_ContentTypeGUID...';


GO
ALTER TABLE [dbo].[tblContentType]
    ADD CONSTRAINT [DF_tblContentType_ContentTypeGUID] DEFAULT (newid()) FOR [ContentTypeGUID];


GO
PRINT N'Creating DF_tblContentType_Registered...';


GO
ALTER TABLE [dbo].[tblContentType]
    ADD CONSTRAINT [DF_tblContentType_Registered] DEFAULT (getdate()) FOR [Created];


GO
PRINT N'Creating DF_tblContentType_MetaDataInherit...';


GO
ALTER TABLE [dbo].[tblContentType]
    ADD CONSTRAINT [DF_tblContentType_MetaDataInherit] DEFAULT (0) FOR [MetaDataInherit];


GO
PRINT N'Creating DF_tblContentType_MetaDataDefault...';


GO
ALTER TABLE [dbo].[tblContentType]
    ADD CONSTRAINT [DF_tblContentType_MetaDataDefault] DEFAULT (0) FOR [MetaDataDefault];


GO
PRINT N'Creating DF_tblContentType_ContentType...';


GO
ALTER TABLE [dbo].[tblContentType]
    ADD CONSTRAINT [DF_tblContentType_ContentType] DEFAULT (0) FOR [ContentType];


GO
PRINT N'Creating DF_tblPropertyDefinitionGroup_SystemGroup...';


GO
ALTER TABLE [dbo].[tblPropertyDefinitionGroup]
    ADD CONSTRAINT [DF_tblPropertyDefinitionGroup_SystemGroup] DEFAULT (0) FOR [SystemGroup];


GO
PRINT N'Creating DF_tblPropertyDefinitionGroup_Access...';


GO
ALTER TABLE [dbo].[tblPropertyDefinitionGroup]
    ADD CONSTRAINT [DF_tblPropertyDefinitionGroup_Access] DEFAULT (10) FOR [Access];


GO
PRINT N'Creating DF_tblPropertyDefinitionGroup_DefaultVisible...';


GO
ALTER TABLE [dbo].[tblPropertyDefinitionGroup]
    ADD CONSTRAINT [DF_tblPropertyDefinitionGroup_DefaultVisible] DEFAULT (1) FOR [GroupVisible];


GO
PRINT N'Creating DF_tblPropertyDefinitionGroup_GroupOrder...';


GO
ALTER TABLE [dbo].[tblPropertyDefinitionGroup]
    ADD CONSTRAINT [DF_tblPropertyDefinitionGroup_GroupOrder] DEFAULT (1) FOR [GroupOrder];


GO
PRINT N'Creating DF_tblPropertyDefinition_DefaultValueType...';


GO
ALTER TABLE [dbo].[tblPropertyDefinition]
    ADD CONSTRAINT [DF_tblPropertyDefinition_DefaultValueType] DEFAULT (0) FOR [DefaultValueType];


GO
PRINT N'Creating DF_tblPropertyDefinition_LongStringSettings...';


GO
ALTER TABLE [dbo].[tblPropertyDefinition]
    ADD CONSTRAINT [DF_tblPropertyDefinition_LongStringSettings] DEFAULT ((-1)) FOR [LongStringSettings];


GO
PRINT N'Creating DF_tblPropertyDefinition_CommonLang...';


GO
ALTER TABLE [dbo].[tblPropertyDefinition]
    ADD CONSTRAINT [DF_tblPropertyDefinition_CommonLang] DEFAULT (0) FOR [LanguageSpecific];


GO
PRINT N'Creating DF_tblPropertyDefinition_ExistsOnModel...';


GO
ALTER TABLE [dbo].[tblPropertyDefinition]
    ADD CONSTRAINT [DF_tblPropertyDefinition_ExistsOnModel] DEFAULT (0) FOR [ExistsOnModel];


GO
PRINT N'Creating DF__tblContent__ContentGUID...';


GO
ALTER TABLE [dbo].[tblContent]
    ADD CONSTRAINT [DF__tblContent__ContentGUID] DEFAULT (newid()) FOR [ContentGUID];


GO
PRINT N'Creating DF__tblContent__Visible__2E06CDA9...';


GO
ALTER TABLE [dbo].[tblContent]
    ADD CONSTRAINT [DF__tblContent__Visible__2E06CDA9] DEFAULT (1) FOR [VisibleInMenu];


GO
PRINT N'Creating DF__tblContent__Deleted__2EFAF1E2...';


GO
ALTER TABLE [dbo].[tblContent]
    ADD CONSTRAINT [DF__tblContent__Deleted__2EFAF1E2] DEFAULT (0) FOR [Deleted];


GO
PRINT N'Creating DF__tblContent__ChildOr__35A7EF71...';


GO
ALTER TABLE [dbo].[tblContent]
    ADD CONSTRAINT [DF__tblContent__ChildOr__35A7EF71] DEFAULT (1) FOR [ChildOrderRule];


GO
PRINT N'Creating DF__tblContent__PeerOrd__369C13AA...';


GO
ALTER TABLE [dbo].[tblContent]
    ADD CONSTRAINT [DF__tblContent__PeerOrd__369C13AA] DEFAULT (100) FOR [PeerOrder];


GO
PRINT N'Creating DF__tblContent__fkMasterLangaugeBranchID...';


GO
ALTER TABLE [dbo].[tblContent]
    ADD CONSTRAINT [DF__tblContent__fkMasterLangaugeBranchID] DEFAULT (1) FOR [fkMasterLanguageBranchID];


GO
PRINT N'Creating DF_tblContent_ContentType...';


GO
ALTER TABLE [dbo].[tblContent]
    ADD CONSTRAINT [DF_tblContent_ContentType] DEFAULT (0) FOR [ContentType];


GO
PRINT N'Creating DF_tblContent_IsLeafNode...';


GO
ALTER TABLE [dbo].[tblContent]
    ADD CONSTRAINT [DF_tblContent_IsLeafNode] DEFAULT (1) FOR [IsLeafNode];


GO
PRINT N'Creating DF_tblFrame_SystemFrame...';


GO
ALTER TABLE [dbo].[tblFrame]
    ADD CONSTRAINT [DF_tblFrame_SystemFrame] DEFAULT (0) FOR [SystemFrame];


GO
PRINT N'Creating DF_tblContentCategory_CategoryType...';


GO
ALTER TABLE [dbo].[tblContentCategory]
    ADD CONSTRAINT [DF_tblContentCategory_CategoryType] DEFAULT (0) FOR [CategoryType];


GO
PRINT N'Creating DF_tblContentCategory_LanguageBranchID...';


GO
ALTER TABLE [dbo].[tblContentCategory]
    ADD CONSTRAINT [DF_tblContentCategory_LanguageBranchID] DEFAULT (1) FOR [fkLanguageBranchID];


GO
PRINT N'Creating DF_tblCategory_CategoryGUID...';


GO
ALTER TABLE [dbo].[tblCategory]
    ADD CONSTRAINT [DF_tblCategory_CategoryGUID] DEFAULT (newid()) FOR [CategoryGUID];


GO
PRINT N'Creating DF_tblCategory_PeerOrder...';


GO
ALTER TABLE [dbo].[tblCategory]
    ADD CONSTRAINT [DF_tblCategory_PeerOrder] DEFAULT (100) FOR [SortOrder];


GO
PRINT N'Creating DF_tblCategory_Available...';


GO
ALTER TABLE [dbo].[tblCategory]
    ADD CONSTRAINT [DF_tblCategory_Available] DEFAULT (1) FOR [Available];


GO
PRINT N'Creating DF_tblCategory_Selectable...';


GO
ALTER TABLE [dbo].[tblCategory]
    ADD CONSTRAINT [DF_tblCategory_Selectable] DEFAULT (1) FOR [Selectable];


GO
PRINT N'Creating DF_tblCategory_SuperCategory...';


GO
ALTER TABLE [dbo].[tblCategory]
    ADD CONSTRAINT [DF_tblCategory_SuperCategory] DEFAULT (0) FOR [SuperCategory];


GO
PRINT N'Creating DF_tblAccess_IsRole...';


GO
ALTER TABLE [dbo].[tblContentAccess]
    ADD CONSTRAINT [DF_tblAccess_IsRole] DEFAULT (1) FOR [IsRole];


GO
PRINT N'Creating FK_tblProjectMember_tblProject...';


GO
ALTER TABLE [dbo].[tblProjectMember]
    ADD CONSTRAINT [FK_tblProjectMember_tblProject] FOREIGN KEY ([fkProjectID]) REFERENCES [dbo].[tblProject] ([pkID]);


GO
PRINT N'Creating FK_tblProjectItem_tblProject...';


GO
ALTER TABLE [dbo].[tblProjectItem]
    ADD CONSTRAINT [FK_tblProjectItem_tblProject] FOREIGN KEY ([fkProjectID]) REFERENCES [dbo].[tblProject] ([pkID]);


GO
PRINT N'Creating FK_tblVisitorGroupStatistic_tblBigTableIdentity...';


GO
ALTER TABLE [dbo].[tblVisitorGroupStatistic]
    ADD CONSTRAINT [FK_tblVisitorGroupStatistic_tblBigTableIdentity] FOREIGN KEY ([pkId]) REFERENCES [dbo].[tblBigTableIdentity] ([pkId]);


GO
PRINT N'Creating FK_tblSystemBigTable_tblBigTableIdentity...';


GO
ALTER TABLE [dbo].[tblSystemBigTable]
    ADD CONSTRAINT [FK_tblSystemBigTable_tblBigTableIdentity] FOREIGN KEY ([pkId]) REFERENCES [dbo].[tblBigTableIdentity] ([pkId]);


GO
PRINT N'Creating FK_tblIndexRequestLog_tblBigTableIdentity...';


GO
ALTER TABLE [dbo].[tblIndexRequestLog]
    ADD CONSTRAINT [FK_tblIndexRequestLog_tblBigTableIdentity] FOREIGN KEY ([pkId]) REFERENCES [dbo].[tblBigTableIdentity] ([pkId]);


GO
PRINT N'Creating FK_ChangeNotification_ChangeNotificationString_ChangeNotificationConnection...';


GO
ALTER TABLE [dbo].[tblChangeNotificationQueuedString]
    ADD CONSTRAINT [FK_ChangeNotification_ChangeNotificationString_ChangeNotificationConnection] FOREIGN KEY ([ConnectionId]) REFERENCES [dbo].[tblChangeNotificationConnection] ([ConnectionId]);


GO
PRINT N'Creating FK_ChangeNotification_ChangeNotificationString_ChangeNotificationProcessor...';


GO
ALTER TABLE [dbo].[tblChangeNotificationQueuedString]
    ADD CONSTRAINT [FK_ChangeNotification_ChangeNotificationString_ChangeNotificationProcessor] FOREIGN KEY ([ProcessorId]) REFERENCES [dbo].[tblChangeNotificationProcessor] ([ProcessorId]);


GO
PRINT N'Creating FK_ChangeNotification_ChangeNotificationInt_ChangeNotificationConnection...';


GO
ALTER TABLE [dbo].[tblChangeNotificationQueuedInt]
    ADD CONSTRAINT [FK_ChangeNotification_ChangeNotificationInt_ChangeNotificationConnection] FOREIGN KEY ([ConnectionId]) REFERENCES [dbo].[tblChangeNotificationConnection] ([ConnectionId]);


GO
PRINT N'Creating FK_ChangeNotification_ChangeNotificationInt_ChangeNotificationProcessor...';


GO
ALTER TABLE [dbo].[tblChangeNotificationQueuedInt]
    ADD CONSTRAINT [FK_ChangeNotification_ChangeNotificationInt_ChangeNotificationProcessor] FOREIGN KEY ([ProcessorId]) REFERENCES [dbo].[tblChangeNotificationProcessor] ([ProcessorId]);


GO
PRINT N'Creating FK_ChangeNotification_ChangeNotificationGuid_ChangeNotificationConnection...';


GO
ALTER TABLE [dbo].[tblChangeNotificationQueuedGuid]
    ADD CONSTRAINT [FK_ChangeNotification_ChangeNotificationGuid_ChangeNotificationConnection] FOREIGN KEY ([ConnectionId]) REFERENCES [dbo].[tblChangeNotificationConnection] ([ConnectionId]);


GO
PRINT N'Creating FK_ChangeNotification_ChangeNotificationGuid_ChangeNotificationProcessor...';


GO
ALTER TABLE [dbo].[tblChangeNotificationQueuedGuid]
    ADD CONSTRAINT [FK_ChangeNotification_ChangeNotificationGuid_ChangeNotificationProcessor] FOREIGN KEY ([ProcessorId]) REFERENCES [dbo].[tblChangeNotificationProcessor] ([ProcessorId]);


GO
PRINT N'Creating FK_ChangeNotificationConnection_ChangeNotificationProcessor...';


GO
ALTER TABLE [dbo].[tblChangeNotificationConnection]
    ADD CONSTRAINT [FK_ChangeNotificationConnection_ChangeNotificationProcessor] FOREIGN KEY ([ProcessorId]) REFERENCES [dbo].[tblChangeNotificationProcessor] ([ProcessorId]);


GO
PRINT N'Creating FK_tblBigTableStoreInfo_tblBigTableStoreConfig...';


GO
ALTER TABLE [dbo].[tblBigTableStoreInfo]
    ADD CONSTRAINT [FK_tblBigTableStoreInfo_tblBigTableStoreConfig] FOREIGN KEY ([fkStoreId]) REFERENCES [dbo].[tblBigTableStoreConfig] ([pkId]);


GO
PRINT N'Creating FK_tblBigTableReference_tblBigTableIdentity...';


GO
ALTER TABLE [dbo].[tblBigTableReference]
    ADD CONSTRAINT [FK_tblBigTableReference_tblBigTableIdentity] FOREIGN KEY ([pkId]) REFERENCES [dbo].[tblBigTableIdentity] ([pkId]);


GO
PRINT N'Creating FK_tblBigTableReference_RefId_tblBigTableIdentity...';


GO
ALTER TABLE [dbo].[tblBigTableReference]
    ADD CONSTRAINT [FK_tblBigTableReference_RefId_tblBigTableIdentity] FOREIGN KEY ([RefIdValue]) REFERENCES [dbo].[tblBigTableIdentity] ([pkId]);


GO
PRINT N'Creating FK_tblBigTable_tblBigTableIdentity...';


GO
ALTER TABLE [dbo].[tblBigTable]
    ADD CONSTRAINT [FK_tblBigTable_tblBigTableIdentity] FOREIGN KEY ([pkId]) REFERENCES [dbo].[tblBigTableIdentity] ([pkId]);


GO
PRINT N'Creating FK_tblXFormData_tblBigTableIdentity...';


GO
ALTER TABLE [dbo].[tblXFormData]
    ADD CONSTRAINT [FK_tblXFormData_tblBigTableIdentity] FOREIGN KEY ([pkId]) REFERENCES [dbo].[tblBigTableIdentity] ([pkId]);


GO
PRINT N'Creating FK_tblWindowsRelations_Group...';


GO
ALTER TABLE [dbo].[tblWindowsRelations]
    ADD CONSTRAINT [FK_tblWindowsRelations_Group] FOREIGN KEY ([fkWindowsGroup]) REFERENCES [dbo].[tblWindowsGroup] ([pkID]);


GO
PRINT N'Creating FK_tblWindowsRelations_User...';


GO
ALTER TABLE [dbo].[tblWindowsRelations]
    ADD CONSTRAINT [FK_tblWindowsRelations_User] FOREIGN KEY ([fkWindowsUser]) REFERENCES [dbo].[tblWindowsUser] ([pkID]);


GO
PRINT N'Creating FK_tblContentLanguageSetting_tblContent...';


GO
ALTER TABLE [dbo].[tblContentLanguageSetting]
    ADD CONSTRAINT [FK_tblContentLanguageSetting_tblContent] FOREIGN KEY ([fkContentID]) REFERENCES [dbo].[tblContent] ([pkID]);


GO
PRINT N'Creating FK_tblContentLanguageSetting_tblLanguageBranch1...';


GO
ALTER TABLE [dbo].[tblContentLanguageSetting]
    ADD CONSTRAINT [FK_tblContentLanguageSetting_tblLanguageBranch1] FOREIGN KEY ([fkLanguageBranchID]) REFERENCES [dbo].[tblLanguageBranch] ([pkID]);


GO
PRINT N'Creating FK_tblContentLanguageSetting_tblLanguageBranch2...';


GO
ALTER TABLE [dbo].[tblContentLanguageSetting]
    ADD CONSTRAINT [FK_tblContentLanguageSetting_tblLanguageBranch2] FOREIGN KEY ([fkReplacementBranchID]) REFERENCES [dbo].[tblLanguageBranch] ([pkID]);


GO
PRINT N'Creating FK_tblContentLanguage_tblWorkContent...';


GO
ALTER TABLE [dbo].[tblContentLanguage]
    ADD CONSTRAINT [FK_tblContentLanguage_tblWorkContent] FOREIGN KEY ([Version]) REFERENCES [dbo].[tblWorkContent] ([pkID]);


GO
PRINT N'Creating FK_tblContentLanguage_tblFrame...';


GO
ALTER TABLE [dbo].[tblContentLanguage]
    ADD CONSTRAINT [FK_tblContentLanguage_tblFrame] FOREIGN KEY ([fkFrameID]) REFERENCES [dbo].[tblFrame] ([pkID]);


GO
PRINT N'Creating FK_tblContentLanguage_tblContent2...';


GO
ALTER TABLE [dbo].[tblContentLanguage]
    ADD CONSTRAINT [FK_tblContentLanguage_tblContent2] FOREIGN KEY ([fkContentID]) REFERENCES [dbo].[tblContent] ([pkID]);


GO
PRINT N'Creating FK_tblContentLanguage_tblLanguageBranch...';


GO
ALTER TABLE [dbo].[tblContentLanguage]
    ADD CONSTRAINT [FK_tblContentLanguage_tblLanguageBranch] FOREIGN KEY ([fkLanguageBranchID]) REFERENCES [dbo].[tblLanguageBranch] ([pkID]);


GO
PRINT N'Creating FK_tblRelation_tblItem_FromId...';


GO
ALTER TABLE [dbo].[tblRelation]
    ADD CONSTRAINT [FK_tblRelation_tblItem_FromId] FOREIGN KEY ([FromId]) REFERENCES [dbo].[tblItem] ([pkID]);


GO
PRINT N'Creating FK_tblRelation_tblItem_ToId...';


GO
ALTER TABLE [dbo].[tblRelation]
    ADD CONSTRAINT [FK_tblRelation_tblItem_ToId] FOREIGN KEY ([ToId]) REFERENCES [dbo].[tblItem] ([pkID]);


GO
PRINT N'Creating FK_tblSchemaItem_tblSchema...';


GO
ALTER TABLE [dbo].[tblSchemaItem]
    ADD CONSTRAINT [FK_tblSchemaItem_tblSchema] FOREIGN KEY ([fkSchemaId]) REFERENCES [dbo].[tblSchema] ([pkID]) ON DELETE CASCADE;


GO
PRINT N'Creating FK_tblUnifiedPathProperty_tblUnifiedPath...';


GO
ALTER TABLE [dbo].[tblUnifiedPathProperty]
    ADD CONSTRAINT [FK_tblUnifiedPathProperty_tblUnifiedPath] FOREIGN KEY ([fkUnifiedPathID]) REFERENCES [dbo].[tblUnifiedPath] ([pkID]);


GO
PRINT N'Creating FK_tblUnifiedPathAcl_tblUnifiedPath...';


GO
ALTER TABLE [dbo].[tblUnifiedPathAcl]
    ADD CONSTRAINT [FK_tblUnifiedPathAcl_tblUnifiedPath] FOREIGN KEY ([fkUnifiedPathID]) REFERENCES [dbo].[tblUnifiedPath] ([pkID]);


GO
PRINT N'Creating FK_tblWorkContentProperty_tblContent...';


GO
ALTER TABLE [dbo].[tblWorkContentProperty]
    ADD CONSTRAINT [FK_tblWorkContentProperty_tblContent] FOREIGN KEY ([ContentLink]) REFERENCES [dbo].[tblContent] ([pkID]);


GO
PRINT N'Creating FK_tblWorkContentProperty_tblPropertyDefinition...';


GO
ALTER TABLE [dbo].[tblWorkContentProperty]
    ADD CONSTRAINT [FK_tblWorkContentProperty_tblPropertyDefinition] FOREIGN KEY ([fkPropertyDefinitionID]) REFERENCES [dbo].[tblPropertyDefinition] ([pkID]);


GO
PRINT N'Creating FK_tblWorkContentProperty_tblContentType...';


GO
ALTER TABLE [dbo].[tblWorkContentProperty]
    ADD CONSTRAINT [FK_tblWorkContentProperty_tblContentType] FOREIGN KEY ([ContentType]) REFERENCES [dbo].[tblContentType] ([pkID]);


GO
PRINT N'Creating FK_tblWorkContentProperty_tblWorkContent...';


GO
ALTER TABLE [dbo].[tblWorkContentProperty]
    ADD CONSTRAINT [FK_tblWorkContentProperty_tblWorkContent] FOREIGN KEY ([fkWorkContentID]) REFERENCES [dbo].[tblWorkContent] ([pkID]);


GO
PRINT N'Creating FK_tblWorkContent_tblFrame...';


GO
ALTER TABLE [dbo].[tblWorkContent]
    ADD CONSTRAINT [FK_tblWorkContent_tblFrame] FOREIGN KEY ([fkFrameID]) REFERENCES [dbo].[tblFrame] ([pkID]);


GO
PRINT N'Creating FK_tblWorkContent_tblContent...';


GO
ALTER TABLE [dbo].[tblWorkContent]
    ADD CONSTRAINT [FK_tblWorkContent_tblContent] FOREIGN KEY ([fkContentID]) REFERENCES [dbo].[tblContent] ([pkID]);


GO
PRINT N'Creating FK_tblWorkContent_tblWorkContent2...';


GO
ALTER TABLE [dbo].[tblWorkContent]
    ADD CONSTRAINT [FK_tblWorkContent_tblWorkContent2] FOREIGN KEY ([fkMasterVersionID]) REFERENCES [dbo].[tblWorkContent] ([pkID]);


GO
PRINT N'Creating FK_tblWorkContent_tblLanguageBranch...';


GO
ALTER TABLE [dbo].[tblWorkContent]
    ADD CONSTRAINT [FK_tblWorkContent_tblLanguageBranch] FOREIGN KEY ([fkLanguageBranchID]) REFERENCES [dbo].[tblLanguageBranch] ([pkID]);


GO
PRINT N'Creating FK_tblWorkContentCategory_tblCategory...';


GO
ALTER TABLE [dbo].[tblWorkContentCategory]
    ADD CONSTRAINT [FK_tblWorkContentCategory_tblCategory] FOREIGN KEY ([fkCategoryID]) REFERENCES [dbo].[tblCategory] ([pkID]);


GO
PRINT N'Creating FK_tblWorkContentCategory_tblWorkContent...';


GO
ALTER TABLE [dbo].[tblWorkContentCategory]
    ADD CONSTRAINT [FK_tblWorkContentCategory_tblWorkContent] FOREIGN KEY ([fkWorkContentID]) REFERENCES [dbo].[tblWorkContent] ([pkID]);


GO
PRINT N'Creating FK_tblTask_tblPlugIn...';


GO
ALTER TABLE [dbo].[tblTask]
    ADD CONSTRAINT [FK_tblTask_tblPlugIn] FOREIGN KEY ([fkPlugInID]) REFERENCES [dbo].[tblPlugIn] ([pkID]);


GO
PRINT N'Creating fk_tblScheduledItemLog_tblScheduledItem...';


GO
ALTER TABLE [dbo].[tblScheduledItemLog]
    ADD CONSTRAINT [fk_tblScheduledItemLog_tblScheduledItem] FOREIGN KEY ([fkScheduledItemId]) REFERENCES [dbo].[tblScheduledItem] ([pkID]);


GO
PRINT N'Creating FK_tblContentProperty_tblContent...';


GO
ALTER TABLE [dbo].[tblContentProperty]
    ADD CONSTRAINT [FK_tblContentProperty_tblContent] FOREIGN KEY ([fkContentID]) REFERENCES [dbo].[tblContent] ([pkID]);


GO
PRINT N'Creating FK_tblContentProperty_tblContent2...';


GO
ALTER TABLE [dbo].[tblContentProperty]
    ADD CONSTRAINT [FK_tblContentProperty_tblContent2] FOREIGN KEY ([ContentLink]) REFERENCES [dbo].[tblContent] ([pkID]);


GO
PRINT N'Creating FK_tblContentProperty_tblPropertyDefinition...';


GO
ALTER TABLE [dbo].[tblContentProperty]
    ADD CONSTRAINT [FK_tblContentProperty_tblPropertyDefinition] FOREIGN KEY ([fkPropertyDefinitionID]) REFERENCES [dbo].[tblPropertyDefinition] ([pkID]);


GO
PRINT N'Creating FK_tblContentProperty_tblLanguageBranch...';


GO
ALTER TABLE [dbo].[tblContentProperty]
    ADD CONSTRAINT [FK_tblContentProperty_tblLanguageBranch] FOREIGN KEY ([fkLanguageBranchID]) REFERENCES [dbo].[tblLanguageBranch] ([pkID]);


GO
PRINT N'Creating FK_tblContentTypeToContentType_tblContentType...';


GO
ALTER TABLE [dbo].[tblContentTypeToContentType]
    ADD CONSTRAINT [FK_tblContentTypeToContentType_tblContentType] FOREIGN KEY ([fkContentTypeParentID]) REFERENCES [dbo].[tblContentType] ([pkID]);


GO
PRINT N'Creating FK_tblContentTypeToContentType_tblContentType1...';


GO
ALTER TABLE [dbo].[tblContentTypeToContentType]
    ADD CONSTRAINT [FK_tblContentTypeToContentType_tblContentType1] FOREIGN KEY ([fkContentTypeChildID]) REFERENCES [dbo].[tblContentType] ([pkID]);


GO
PRINT N'Creating FK_tblContentTypeDefault_tblContentType...';


GO
ALTER TABLE [dbo].[tblContentTypeDefault]
    ADD CONSTRAINT [FK_tblContentTypeDefault_tblContentType] FOREIGN KEY ([fkContentTypeID]) REFERENCES [dbo].[tblContentType] ([pkID]);


GO
PRINT N'Creating FK_tblContentSoftlink_tblContent...';


GO
ALTER TABLE [dbo].[tblContentSoftlink]
    ADD CONSTRAINT [FK_tblContentSoftlink_tblContent] FOREIGN KEY ([fkOwnerContentID]) REFERENCES [dbo].[tblContent] ([pkID]);


GO
PRINT N'Creating FK_tblPropertyDefinition_tblContentType...';


GO
ALTER TABLE [dbo].[tblPropertyDefinition]
    ADD CONSTRAINT [FK_tblPropertyDefinition_tblContentType] FOREIGN KEY ([fkContentTypeID]) REFERENCES [dbo].[tblContentType] ([pkID]);


GO
PRINT N'Creating FK_tblContent_tblContent...';


GO
ALTER TABLE [dbo].[tblContent]
    ADD CONSTRAINT [FK_tblContent_tblContent] FOREIGN KEY ([fkParentID]) REFERENCES [dbo].[tblContent] ([pkID]);


GO
PRINT N'Creating FK_tblContent_tblContentType...';


GO
ALTER TABLE [dbo].[tblContent]
    ADD CONSTRAINT [FK_tblContent_tblContentType] FOREIGN KEY ([fkContentTypeID]) REFERENCES [dbo].[tblContentType] ([pkID]);


GO
PRINT N'Creating FK_tblContent_tblLanguageBranch...';


GO
ALTER TABLE [dbo].[tblContent]
    ADD CONSTRAINT [FK_tblContent_tblLanguageBranch] FOREIGN KEY ([fkMasterLanguageBranchID]) REFERENCES [dbo].[tblLanguageBranch] ([pkID]);


GO
PRINT N'Creating FK_tblContentCategory_tblCategory...';


GO
ALTER TABLE [dbo].[tblContentCategory]
    ADD CONSTRAINT [FK_tblContentCategory_tblCategory] FOREIGN KEY ([fkCategoryID]) REFERENCES [dbo].[tblCategory] ([pkID]);


GO
PRINT N'Creating FK_tblContentCategory_tblContent...';


GO
ALTER TABLE [dbo].[tblContentCategory]
    ADD CONSTRAINT [FK_tblContentCategory_tblContent] FOREIGN KEY ([fkContentID]) REFERENCES [dbo].[tblContent] ([pkID]);


GO
PRINT N'Creating FK_tblCategory_tblCategory...';


GO
ALTER TABLE [dbo].[tblCategory]
    ADD CONSTRAINT [FK_tblCategory_tblCategory] FOREIGN KEY ([fkParentID]) REFERENCES [dbo].[tblCategory] ([pkID]);


GO
PRINT N'Creating FK_tblContentAccess_tblContent...';


GO
ALTER TABLE [dbo].[tblContentAccess]
    ADD CONSTRAINT [FK_tblContentAccess_tblContent] FOREIGN KEY ([fkContentID]) REFERENCES [dbo].[tblContent] ([pkID]);


GO
PRINT N'Creating CH_tblVisitorGroupStatistic...';


GO
ALTER TABLE [dbo].[tblVisitorGroupStatistic]
    ADD CONSTRAINT [CH_tblVisitorGroupStatistic] CHECK ([Row]>=1);


GO
PRINT N'Creating CH_tblSystemBigTable...';


GO
ALTER TABLE [dbo].[tblSystemBigTable]
    ADD CONSTRAINT [CH_tblSystemBigTable] CHECK ([Row]>=1);


GO
PRINT N'Creating CH_tblIndexRequestLog...';


GO
ALTER TABLE [dbo].[tblIndexRequestLog]
    ADD CONSTRAINT [CH_tblIndexRequestLog] CHECK ([Row]>=1);


GO
PRINT N'Creating CK_ChangeNotificationProcessor_ChangeNotificationDataType...';


GO
ALTER TABLE [dbo].[tblChangeNotificationProcessor]
    ADD CONSTRAINT [CK_ChangeNotificationProcessor_ChangeNotificationDataType] CHECK ([ChangeNotificationDataType]='Guid' OR [ChangeNotificationDataType]='String' OR [ChangeNotificationDataType]='Int');


GO
PRINT N'Creating CK_ChangeNotificationProcessor_ProcessorStatus...';


GO
ALTER TABLE [dbo].[tblChangeNotificationProcessor]
    ADD CONSTRAINT [CK_ChangeNotificationProcessor_ProcessorStatus] CHECK ([ProcessorStatus]='valid' OR [ProcessorStatus]='recovering' OR [ProcessorStatus]='invalid');


GO
PRINT N'Creating CH_tblBigTableReference_Index...';


GO
ALTER TABLE [dbo].[tblBigTableReference]
    ADD CONSTRAINT [CH_tblBigTableReference_Index] CHECK ([Index]>=-1);


GO
PRINT N'Creating CH_tblBigTable...';


GO
ALTER TABLE [dbo].[tblBigTable]
    ADD CONSTRAINT [CH_tblBigTable] CHECK ([Row]>=1);


GO
PRINT N'Creating CH_tblXFormData...';


GO
ALTER TABLE [dbo].[tblXFormData]
    ADD CONSTRAINT [CH_tblXFormData] CHECK (([Row]>=(1)));


GO
PRINT N'Creating CK_tblScheduledItem...';


GO
ALTER TABLE [dbo].[tblScheduledItem]
    ADD CONSTRAINT [CK_tblScheduledItem] CHECK ([DatePart] = 'yy' or ([DatePart] = 'mm' or ([DatePart] = 'wk' or ([DatePart] = 'dd' or ([DatePart] = 'hh' or ([DatePart] = 'mi' or ([DatePart] = 'ss' or [DatePart] = 'ms')))))));


GO
PRINT N'Creating [dbo].[BigTableDateTimeSubtract]...';


GO
create FUNCTION dbo.BigTableDateTimeSubtract
(
	@DateTime1 DateTime,
	@DateTime2 DateTime
)
RETURNS BigInt
AS
BEGIN

declare @Return BigInt

Select @Return = (Convert(BigInt, 
	DATEDIFF(day, @DateTime1, @DateTime2)) * 86400000) + 
	(DATEDIFF(millisecond, 
		DATEADD(day, 
			DATEDIFF(day, @DateTime1, @DateTime2)
		, @DateTime1)
	, @DateTime2
	)
)

return @Return
END
GO
PRINT N'Creating [dbo].[netDateTimeSubtract]...';


GO
create FUNCTION dbo.netDateTimeSubtract
(
	@DateTime1 DateTime,
	@DateTime2 DateTime
)
RETURNS BigInt
AS
BEGIN

declare @Return BigInt

Select @Return = (Convert(BigInt, 
	DATEDIFF(day, @DateTime1, @DateTime2)) * 86400000) + 
	(DATEDIFF(millisecond, 
		DATEADD(day, 
			DATEDIFF(day, @DateTime1, @DateTime2)
		, @DateTime1)
	, @DateTime2
	)
)

return @Return
END
GO
PRINT N'Creating [dbo].[ConvertScopeName]...';


GO
CREATE FUNCTION [dbo].[ConvertScopeName]
(
	@ScopeName nvarchar(450),
	@OldDefinitionID int,
	@NewDefinitionID int	
)
RETURNS nvarchar(450)
AS
BEGIN
	DECLARE @ConvertedScopeName nvarchar(450)

	set @ConvertedScopeName = REPLACE(@ScopeName, 
						'.' + CAST(@OldDefinitionID as varchar) + '.', 
						'.'+ CAST(@NewDefinitionID as varchar) +'.')
	RETURN @ConvertedScopeName
END
GO
PRINT N'Creating [dbo].[GetScopedBlockProperties]...';


GO
CREATE FUNCTION [dbo].[GetScopedBlockProperties] 
(
	@ContentTypeID int
)
RETURNS @ScopedPropertiesTable TABLE 
(
	ScopeName nvarchar(450)
)
AS
BEGIN
	WITH ScopedProperties(ContentTypeID, PropertyDefinitionID, Scope, Level)
	AS
	(
		--Top level statement
		SELECT T1.pkID as ContentTypeID, tblPropertyDefinition.pkID as PropertyDefinitionID, 
			Cast('.' + CAST(tblPropertyDefinition.pkID as VARCHAR) + '.' as varchar) as Scope, 0 as Level
		FROM tblPropertyDefinition
		INNER JOIN tblContentType AS T1 ON T1.pkID=tblPropertyDefinition.fkContentTypeID
		INNER JOIN tblPropertyDefinitionType ON tblPropertyDefinitionType.pkID = tblPropertyDefinition.fkPropertyDefinitionTypeID
		INNER JOIN tblContentType ON tblPropertyDefinitionType.fkContentTypeGUID = tblContentType.ContentTypeGUID
		WHERE tblContentType.pkID = @ContentTypeID
		UNION ALL
		
		--Recursive statement
		SELECT T1.pkID as ContentTypeID, tblPropertyDefinition.pkID as PropertyDefinitionID, 
			Cast('.' + CAST(tblPropertyDefinition.pkID as VARCHAR) + Scope as varchar ) as Scope, ScopedProperties.Level+1 as Level
		FROM tblPropertyDefinition
		INNER JOIN tblContentType AS T1 ON T1.pkID=tblPropertyDefinition.fkContentTypeID
		INNER JOIN tblPropertyDefinitionType ON tblPropertyDefinitionType.pkID = tblPropertyDefinition.fkPropertyDefinitionTypeID
		INNER JOIN tblContentType ON tblPropertyDefinitionType.fkContentTypeGUID = tblContentType.ContentTypeGUID
		INNER JOIN ScopedProperties ON ScopedProperties.ContentTypeID = tblContentType.pkID
	)

	INSERT INTO @ScopedPropertiesTable(ScopeName) SELECT Scope from ScopedProperties
	
	RETURN 
END
GO
PRINT N'Creating [dbo].[GetExistingScopesForDefinition]...';


GO
CREATE FUNCTION [dbo].[GetExistingScopesForDefinition] 
(
	@PropertyDefinitionID int
)
RETURNS @ScopedPropertiesTable TABLE 
(
	ScopeName nvarchar(450)
)
AS
BEGIN
	--Get blocktype if property is block property
	DECLARE @ContentTypeID INT;
	SET @ContentTypeID = (SELECT tblContentType.pkID FROM 
		tblPropertyDefinition
		INNER JOIN tblPropertyDefinitionType ON tblPropertyDefinition.fkPropertyDefinitionTypeID = tblPropertyDefinitionType.pkID
		INNER JOIN tblContentType ON tblPropertyDefinitionType.fkContentTypeGUID = tblContentType.ContentTypeGUID
		WHERE tblPropertyDefinition.pkID = @PropertyDefinitionID);
		
	IF (@ContentTypeID IS NOT NULL)
	BEGIN
		INSERT INTO @ScopedPropertiesTable
		SELECT Property.ScopeName FROM
			tblWorkContentProperty as Property WITH(INDEX(IDX_tblWorkContentProperty_ScopeName))
			INNER JOIN dbo.GetScopedBlockProperties(@ContentTypeID) as ScopedProperties ON 
				Property.ScopeName LIKE (ScopedProperties.ScopeName + '%')
				WHERE ScopedProperties.ScopeName LIKE ('%.' + CAST(@PropertyDefinitionID as VARCHAR)+ '.')
	END
	
	RETURN 
END
GO
PRINT N'Creating [dbo].[tblWorkProperty]...';


GO
CREATE VIEW [dbo].[tblWorkProperty]
AS
SELECT
	[pkID],
	[fkPropertyDefinitionID] AS fkPageDefinitionID,
	[fkWorkContentID] AS fkWorkPageID,
	[ScopeName],
	[Boolean],
	[Number],
	[FloatNumber],
	[ContentType] AS PageType,
	[ContentLink] AS PageLink,
	[Date],
	[String],
	[LongString],
	[LinkGuid]
FROM    dbo.tblWorkContentProperty
GO
PRINT N'Creating [dbo].[tblPropertyDefault]...';


GO
CREATE VIEW [dbo].[tblPropertyDefault]
AS
SELECT
	[pkID],
	[fkPropertyDefinitionID] AS fkPageDefinitionID,
	[Boolean],
	[Number],
	[FloatNumber],
	[ContentType] AS PageType,
	[ContentLink] AS PageLink,
	[Date],
	[String],
	[LongString],
	[LinkGuid]
FROM    dbo.tblPropertyDefinitionDefault
GO
PRINT N'Creating [dbo].[tblWorkCategory]...';


GO
CREATE VIEW [dbo].[tblWorkCategory]
AS
SELECT
	[fkWorkContentID] AS fkWorkPageID,
	[fkCategoryID],
	[CategoryType]
FROM    dbo.tblWorkContentCategory
GO
PRINT N'Creating [dbo].[tblProperty]...';


GO
CREATE VIEW [dbo].[tblProperty]
AS
SELECT
	[pkID],
	[fkPropertyDefinitionID] AS fkPageDefinitionID,
	[fkContentID] AS fkPageID,
	[fkLanguageBranchID],
	[ScopeName],
	[guid],
	[Boolean],
	[Number],
	[FloatNumber],
	[ContentType] AS PageType,
	[ContentLink] AS PageLink,
	[Date],
	[String],
	[LongString],
	[LongStringLength],
	[LinkGuid]
FROM    dbo.tblContentProperty
GO
PRINT N'Creating [dbo].[tblPageLanguageSetting]...';


GO
CREATE VIEW [dbo].[tblPageLanguageSetting]
AS
SELECT
		[fkContentID] AS fkPageID,
		[fkLanguageBranchID],
		[fkReplacementBranchID],
    	[LanguageBranchFallback],
    	[Active]
FROM    dbo.tblContentLanguageSetting
GO
PRINT N'Creating [dbo].[tblPageLanguage]...';


GO
CREATE VIEW [dbo].[tblPageLanguage]
AS
SELECT
	[fkContentID] AS fkPageID,
	[fkLanguageBranchID],
	[ContentLinkGUID] AS PageLinkGUID,
	[fkFrameID],
	[CreatorName],
    [ChangedByName],
    [ContentGUID] AS PageGUID,
    [Name],
    [URLSegment],
    [LinkURL],
	[BlobUri],
	[ThumbnailUri],
    [ExternalURL],
    [AutomaticLink],
    [FetchData],
    CASE WHEN Status = 4 THEN CAST(0 AS BIT) ELSE CAST(1 AS BIT) END AS PendingPublish,
    [Created],
    [Changed],
    [Saved],
    [StartPublish],
    [StopPublish],
    [Version],
	[Status]

FROM    dbo.tblContentLanguage
GO
PRINT N'Creating [dbo].[tblWorkPage]...';


GO
CREATE VIEW [dbo].[tblWorkPage]
AS
SELECT
	[pkID],
    [fkContentID] AS fkPageID,
    [fkMasterVersionID],
    [ContentLinkGUID] AS PageLinkGUID,
    [fkFrameID],
    [ArchiveContentGUID] as ArchivePageGUID,
    [ChangedByName],
    [NewStatusByName],
    [Name],
    [URLSegment],
    [LinkURL],
	[BlobUri],
	[ThumbnailUri],
    [ExternalURL],
    [VisibleInMenu],
    [LinkType],
    [Created],
    [Saved],
    [StartPublish],
    [StopPublish],
    [ChildOrderRule],
    [PeerOrder],
    CASE WHEN Status = 3 THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS ReadyToPublish,
    [ChangedOnPublish],
    CASE WHEN Status = 5 THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS HasBeenPublished,
    CASE WHEN Status = 1 THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS Rejected,
    CASE WHEN Status = 6 THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS DelayedPublish,
    [RejectComment],
    [fkLanguageBranchID],
	[CommonDraft]
FROM    dbo.tblWorkContent
GO
PRINT N'Creating [dbo].[tblPageTypeToPageType]...';


GO
CREATE VIEW [dbo].[tblPageTypeToPageType]
AS
SELECT
	[fkContentTypeParentID] AS fkPageTypeParentID,
	[fkContentTypeChildID] AS fkPageTypeChildID,
	[Access],
	[Availability],
	[Allow]
FROM    dbo.tblContentTypeToContentType
GO
PRINT N'Creating [dbo].[tblPageTypeDefault]...';


GO
CREATE VIEW [dbo].[tblPageTypeDefault]
AS
SELECT
	[pkID],
	[fkContentTypeID] AS fkPageTypeID,
	[fkContentLinkID] AS fkPageLinkID,
	[fkFrameID],
	[fkArchiveContentID] AS fkArchivePageID,
	[Name],
	[VisibleInMenu],
	[StartPublishOffsetValue],
	[StartPublishOffsetType],
	[StopPublishOffsetValue],
	[StopPublishOffsetType],
	[ChildOrderRule],
	[PeerOrder],
	[StartPublishOffset],
	[StopPublishOffset]
FROM    dbo.tblContentTypeDefault
GO
PRINT N'Creating [dbo].[tblPageType]...';


GO
CREATE VIEW [dbo].[tblPageType]
AS
SELECT
  [pkID],
  [ContentTypeGUID] AS PageTypeGUID,
  [Created],
  [DefaultWebFormTemplate],
  [DefaultMvcController],
  [Filename],
  [ModelType],
  [Name],
  [DisplayName],
  [Description],
  [IdString],
  [Available],
  [SortOrder],
  [MetaDataInherit],
  [MetaDataDefault],
  [WorkflowEditFields],
  [ACL],
  [ContentType]
FROM    dbo.tblContentType
GO
PRINT N'Creating [dbo].[tblPageDefinitionType]...';


GO
CREATE VIEW [dbo].[tblPageDefinitionType]
AS
SELECT
	[pkID],
	[Property],
	[Name],
	[TypeName],
	[AssemblyName],
	[fkContentTypeGUID] AS fkPageTypeGUID
FROM    dbo.tblPropertyDefinitionType
GO
PRINT N'Creating [dbo].[tblPageDefinitionGroup]...';


GO
CREATE VIEW [dbo].[tblPageDefinitionGroup]
AS
SELECT
	[pkID],
	[SystemGroup],
	[Access],
	[GroupVisible],
	[GroupOrder],
	[Name],
	[DisplayName]
FROM    dbo.tblPropertyDefinitionGroup
GO
PRINT N'Creating [dbo].[tblPageDefinition]...';


GO
CREATE VIEW [dbo].[tblPageDefinition]
AS
SELECT  [pkID],
		[fkContentTypeID] AS fkPageTypeID,
		[fkPropertyDefinitionTypeID] AS fkPageDefinitionTypeID,
		[FieldOrder],
		[Name],
		[Property],
		[Required],
		[Advanced],
		[Searchable],
		[EditCaption],
		[HelpText],
		[ObjectProgID],
		[DefaultValueType],
		[LongStringSettings],
		[SettingsID],
		[LanguageSpecific],
		[DisplayEditUI],
		[ExistsOnModel]
FROM    dbo.tblPropertyDefinition
GO
PRINT N'Creating [dbo].[tblPage]...';


GO
CREATE VIEW [dbo].[tblPage]
AS
SELECT  [pkID],
		[fkContentTypeID] AS fkPageTypeID,
		[fkParentID],
		[ArchiveContentGUID] AS ArchivePageGUID,
		[CreatorName],
		[ContentGUID] AS PageGUID,
		[VisibleInMenu],
		[Deleted],
		CAST (0 AS BIT) AS PendingPublish,
		[ChildOrderRule],
		[PeerOrder],
		[ExternalFolderID],
		[ContentAssetsID],
		[ContentOwnerID],
		NULL as PublishedVersion,
		[fkMasterLanguageBranchID],
		[ContentPath] AS PagePath,
		[ContentType],
		[DeletedBy],
		[DeletedDate]
FROM    dbo.tblContent
GO
PRINT N'Creating [dbo].[tblCategoryPage]...';


GO
CREATE VIEW [dbo].[tblCategoryPage]
AS
SELECT  [fkContentID] AS fkPageID,
		[fkCategoryID],
		[CategoryType],
		[fkLanguageBranchID]
FROM    dbo.tblContentCategory
GO
PRINT N'Creating [dbo].[netMappedIdentityMapContent]...';


GO
CREATE PROCEDURE [dbo].[netMappedIdentityMapContent]
	@Provider NVARCHAR(255),
	@ProviderUniqueId NVARCHAR(2048),
	@ExistingContentId INT,
	@ExistingCustomProvider BIT = NULL,
	@ContentGuid UniqueIdentifier
AS
BEGIN
	SET NOCOUNT ON;

	--Return 1 if already exist entry
	IF EXISTS(SELECT 1 FROM tblMappedIdentity WHERE Provider=@Provider AND ProviderUniqueId = @ProviderUniqueId)
	BEGIN
		RETURN 1
	END

	INSERT INTO tblMappedIdentity(Provider, ProviderUniqueId, ContentGuid, ExistingContentId, ExistingCustomProvider) 
		VALUES(@Provider, @ProviderUniqueId, @ContentGuid, @ExistingContentId, @ExistingCustomProvider)

	RETURN 0
END
GO
PRINT N'Creating [dbo].[netMappedIdentityListProviders]...';


GO
CREATE PROCEDURE [dbo].[netMappedIdentityListProviders]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT DISTINCT Provider
	FROM tblMappedIdentity 
END
GO
PRINT N'Creating [dbo].[netMappedIdentityDelete]...';


GO
CREATE PROCEDURE [dbo].[netMappedIdentityDelete]
	@Provider NVARCHAR(255),
	@ProviderUniqueId NVARCHAR(2048)
AS
BEGIN
	SET NOCOUNT ON;

	DELETE
	FROM tblMappedIdentity
	WHERE tblMappedIdentity.Provider = @Provider AND tblMappedIdentity.ProviderUniqueId = @ProviderUniqueId
END
GO
PRINT N'Creating [dbo].[netMappedIdentityGetByGuid]...';


GO
CREATE PROCEDURE [dbo].[netMappedIdentityGetByGuid]
	@ContentGuids dbo.GuidParameterTable READONLY
AS
BEGIN
	SET NOCOUNT ON;

	SELECT MI.pkID AS ContentId, MI.Provider, MI.ProviderUniqueId, MI.ContentGuid, MI.ExistingContentId, MI.ExistingCustomProvider
	FROM tblMappedIdentity AS MI INNER JOIN @ContentGuids AS EI ON MI.ContentGuid = EI.Id
END
GO
PRINT N'Creating [dbo].[netMappedIdentityGetById]...';


GO
CREATE PROCEDURE [dbo].[netMappedIdentityGetById]
	@InternalIds dbo.ContentReferenceTable READONLY
AS
BEGIN
	SET NOCOUNT ON;

	SELECT MI.pkID AS ContentId, MI.Provider, MI.ProviderUniqueId, MI.ContentGuid, MI.ExistingContentId, MI.ExistingCustomProvider
	FROM tblMappedIdentity AS MI 
	INNER JOIN @InternalIds AS EI ON (MI.pkID = EI.ID AND MI.Provider = EI.Provider)
	UNION (SELECT MI2.pkID AS ContentId, MI2.Provider, MI2.ProviderUniqueId, MI2.ContentGuid, MI2.ExistingContentId, MI2.ExistingCustomProvider
		FROM tblMappedIdentity AS MI2
		INNER JOIN @InternalIds AS EI2 ON (MI2.ExistingContentId = EI2.ID)
		WHERE ((MI2.ExistingCustomProvider = 1 AND MI2.Provider = EI2.Provider) OR (MI2.ExistingCustomProvider IS NULL AND EI2.Provider IS NULL)))
	END
GO
PRINT N'Creating [dbo].[netMappedIdentityForProvider]...';


GO
CREATE PROCEDURE [dbo].[netMappedIdentityForProvider]
	@Provider NVARCHAR(255)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT MI.pkID AS ContentId, MI.Provider, MI.ProviderUniqueId, MI.ContentGuid, Mi.ExistingContentId, MI.ExistingCustomProvider
	FROM tblMappedIdentity AS MI
	WHERE MI.Provider = @Provider
END
GO
PRINT N'Creating [dbo].[netMappedIdentityGetOrCreate]...';


GO
CREATE PROCEDURE [dbo].[netMappedIdentityGetOrCreate]
	@ExternalIds dbo.UriPartsTable READONLY,
	@CreateIfMissing BIT
AS
BEGIN
	SET NOCOUNT ON;

	--Create first missing entries
	IF @CreateIfMissing = 1
	BEGIN
		MERGE tblMappedIdentity AS TARGET
		USING @ExternalIds AS Source
		ON (Target.Provider = Source.Host AND Target.ProviderUniqueId = Source.Path)
		WHEN NOT MATCHED BY Target THEN
			INSERT (Provider, ProviderUniqueId)
			VALUES (Source.Host, Source.Path);
	END

	SELECT MI.pkID AS ContentId, MI.Provider, MI.ProviderUniqueId, MI.ContentGuid, MI.ExistingContentId, MI.ExistingCustomProvider
	FROM tblMappedIdentity AS MI INNER JOIN @ExternalIds AS EI ON MI.ProviderUniqueId = EI.Path
	WHERE MI.Provider = EI.Host
END
GO
PRINT N'Creating [dbo].[netWinRolesListStatuses]...';


GO
CREATE PROCEDURE dbo.netWinRolesListStatuses 
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
    SELECT
        GroupName as Name, Enabled
    FROM
        tblWindowsGroup
    ORDER BY
        GroupName     
END
GO
PRINT N'Creating [dbo].[netWinRoleEnableDisable]...';


GO
CREATE PROCEDURE dbo.netWinRoleEnableDisable
(
	@GroupName NVARCHAR(255),
	@Enable BIT
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
    UPDATE tblWindowsGroup
        SET Enabled = @Enable
    WHERE
        LoweredGroupName=LOWER(@GroupName)
END
GO
PRINT N'Creating [dbo].[netProjectItemGetSingle]...';


GO
CREATE PROCEDURE [dbo].[netProjectItemGetSingle]
	@ID INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		  pkID, fkProjectID, ContentLinkID, ContentLinkWorkID, ContentLinkProvider, [Language], Category
	FROM
		tblProjectItem
	WHERE pkID = @ID
END
GO
PRINT N'Creating [dbo].[netProjectItemGetByReferences]...';


GO
CREATE PROCEDURE [dbo].[netProjectItemGetByReferences]
	@References dbo.ContentReferenceTable READONLY
AS
BEGIN
	SET NOCOUNT ON;
	--ProjectItems
	SELECT
		tblProjectItem.pkID, tblProjectItem.fkProjectID, tblProjectItem.ContentLinkID, tblProjectItem.ContentLinkWorkID, tblProjectItem.ContentLinkProvider, tblProjectItem.Language, tblProjectItem.Category
	FROM
		tblProjectItem
	INNER JOIN @References AS Refs ON ((Refs.ID = tblProjectItem.ContentLinkID) AND 
											 (Refs.WorkID = 0 OR  Refs.WorkID = tblProjectItem.ContentLinkWorkID) AND 
											 (Refs.Provider = tblProjectItem.ContentLinkProvider)) 

END
GO
PRINT N'Creating [dbo].[netProjectItemGet]...';


GO
CREATE PROCEDURE [dbo].[netProjectItemGet]
	@ProjectID INT,
	@StartIndex INT = 0,
	@MaxRows INT,
	@Category VARCHAR(2555) = NULL,
	@Language VARCHAR(17) = NULL
AS
BEGIN
	SET NOCOUNT ON;

	WITH PageCTE AS
    (SELECT pkID,fkProjectID, ContentLinkID, ContentLinkWorkID, ContentLinkProvider, Language, Category,
     ROW_NUMBER() OVER(ORDER By pkID) AS intRow
     FROM tblProjectItem
	 WHERE	(@Category IS NULL OR tblProjectItem.Category = @Category) AND 
			(@Language IS NULL OR tblProjectItem.Language = @Language OR tblProjectItem.Language = '') AND
			(tblProjectItem.fkProjectID = @ProjectID))
	 
	--ProjectItems
	SELECT
		  pkID, fkProjectID, ContentLinkID, ContentLinkWorkID, ContentLinkProvider, Language, Category, (SELECT COUNT(*) FROM PageCTE) AS 'TotalRows'
	FROM
		PageCTE
	WHERE intRow BETWEEN (@StartIndex +1) AND (@MaxRows + @StartIndex)
END
GO
PRINT N'Creating [dbo].[netProjectItemDelete]...';


GO
CREATE PROCEDURE [dbo].[netProjectItemDelete]
	@ProjectItemIDs dbo.IDTable READONLY
AS
BEGIN
	SET NOCOUNT ON

	MERGE tblProjectItem AS Target
	USING @ProjectItemIDs AS Source
    ON (Target.pkID = Source.ID)
    WHEN MATCHED THEN 
		DELETE
	OUTPUT DELETED.pkID, DELETED.fkProjectID, DELETED.ContentLinkID, DELETED.ContentLinkWorkID, DELETED.ContentLinkProvider, DELETED.Language, DELETED.Category;
END
GO
PRINT N'Creating [dbo].[netProjectItemSave]...';


GO
CREATE PROCEDURE [dbo].[netProjectItemSave]
	@ProjectItems dbo.ProjectItemTable READONLY
AS
BEGIN
	SET NOCOUNT ON

	MERGE tblProjectItem AS Target
	USING @ProjectItems AS Source
    ON (Target.pkID = Source.ID)
    WHEN MATCHED THEN
        UPDATE SET 
			Target.fkProjectID = Source.ProjectID,
			Target.ContentLinkID = Source.ContentLinkID,
			Target.ContentLinkWorkID = Source.ContentLinkWorkID,
			Target.ContentLinkProvider = Source.ContentLinkProvider,
			Target.Language = Source.Language,
			Target.Category = Source.Category
	WHEN NOT MATCHED BY Target THEN
		INSERT (fkProjectID, ContentLinkID, ContentLinkWorkID, ContentLinkProvider, Language, Category)
		VALUES (Source.ProjectID, Source.ContentLinkID, Source.ContentLinkWorkID, Source.ContentLinkProvider, Source.Language, Source.Category)
	OUTPUT INSERTED.pkID, INSERTED.fkProjectID, INSERTED.ContentLinkID, INSERTED.ContentLinkWorkID, INSERTED.ContentLinkProvider, INSERTED.Language, INSERTED.Category;

END
GO
PRINT N'Creating [dbo].[netProjectList]...';


GO
CREATE PROCEDURE [dbo].[netProjectList]
	@StartIndex INT = 0,
	@MaxRows INT,
	@Status INT = -1
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @projectIDs TABLE(projectID INT NOT NULL, TotalRows INT NOT NULL);

	WITH PageCTE AS
    (SELECT pkID, [Status],
     ROW_NUMBER() OVER(ORDER BY Name ASC, pkID ASC) AS intRow
     FROM tblProject
	 WHERE @Status  = -1 OR @Status = [Status])

	INSERT INTO  @projectIDs 
		SELECT PageCTE.pkID, (SELECT COUNT(*) FROM PageCTE) AS 'TotalRows' 
		FROM PageCTE 
		WHERE intRow BETWEEN (@StartIndex +1) AND (@MaxRows + @StartIndex)

	--Projects
	SELECT 
		pkID, Name, IsPublic, CreatedBy, Created, [Status], DelayPublishUntil, PublishingTrackingToken
	FROM 
		tblProject 
	INNER JOIN @projectIDs AS projects ON projects.projectID = tblProject.pkID


	--ProjectMembers
	SELECT 
		pkID, projectID, Name, Type
	FROM 
		tblProjectMember 
	INNER JOIN @projectIDs AS projects ON projects.projectID = tblProjectMember.fkProjectID
	ORDER BY projectID, Name

	RETURN COALESCE((SELECT TOP 1 TotalRows FROM @projectIDs), 0)

END
GO
PRINT N'Creating [dbo].[netProjectDelete]...';


GO
CREATE PROCEDURE [dbo].[netProjectDelete]
	@ID	INT
AS
	SET NOCOUNT ON
		DELETE FROM tblProjectItem WHERE fkProjectID = @ID
		DELETE FROM tblProjectMember WHERE fkProjectID = @ID 
		DELETE FROM tblProject WHERE pkID = @ID 
	RETURN @@ROWCOUNT
GO
PRINT N'Creating [dbo].[netProjectGet]...';


GO
CREATE PROCEDURE [dbo].[netProjectGet]
	@ID int
AS
BEGIN
	SELECT pkID, IsPublic, Name, Created, CreatedBy, [Status], DelayPublishUntil, PublishingTrackingToken
	FROM tblProject
	WHERE tblProject.pkID = @ID

	SELECT pkID, Name, Type
	FROM tblProjectMember
	WHERE tblProjectMember.fkProjectID = @ID
	ORDER BY Name ASC
END
GO
PRINT N'Creating [dbo].[netProjectSave]...';


GO

CREATE PROCEDURE [dbo].[netProjectSave]
	@ID INT,
	@Name	nvarchar(255),
	@IsPublic BIT,
	@Created	datetime,
	@CreatedBy	nvarchar(255),
	@Status INT,
	@DelayPublishUntil datetime = NULL,
	@PublishingTrackingToken nvarchar(255),
	@Members dbo.ProjectMemberTable READONLY
AS
BEGIN
	SET NOCOUNT ON

	IF @ID=0
	BEGIN
		INSERT INTO tblProject(Name, IsPublic, Created, CreatedBy, [Status], DelayPublishUntil, PublishingTrackingToken) VALUES(@Name, @IsPublic, @Created, @CreatedBy, @Status, @DelayPublishUntil, @PublishingTrackingToken)
		SET @ID = SCOPE_IDENTITY()
	END
	ELSE
	BEGIN
		UPDATE tblProject SET Name=@Name, IsPublic=@IsPublic, [Status] = @Status, DelayPublishUntil = @DelayPublishUntil, PublishingTrackingToken = @PublishingTrackingToken  WHERE pkID=@ID
	END

	MERGE tblProjectMember AS Target
    USING @Members AS Source
    ON (Target.pkID = Source.ID AND Target.fkProjectID=@ID)
    WHEN MATCHED THEN 
        UPDATE SET Name = Source.Name, Type = Source.Type
	WHEN NOT MATCHED BY Source AND Target.fkProjectID = @ID THEN
		DELETE
	WHEN NOT MATCHED BY Target THEN
		INSERT (fkProjectID, Name, Type)
		VALUES (@ID, Source.Name, Source.Type);


	SELECT pkID, Name, Type
	FROM tblProjectMember
	WHERE tblProjectMember.fkProjectID = @ID
	ORDER BY Name ASC

	RETURN @ID
END
GO
PRINT N'Creating [dbo].[netContentListVersionsPaged]...';


GO
CREATE PROCEDURE dbo.netContentListVersionsPaged
(
	@Binary VARBINARY(8000),
	@Threshold INT = 0
)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @ContentVersions TABLE (VersionID INT, ContentID INT, MasterVersionID INT, LanguageBranchID INT, ContentTypeID INT)
	DECLARE @WorkId INT;
	DECLARE	@Length SMALLINT
	DECLARE @Index SMALLINT
	SET @Index = 1
	SET @Length = DATALENGTH(@Binary)
	WHILE (@Index <= @Length)
	BEGIN
		SET @WorkId = SUBSTRING(@Binary, @Index, 4)

		INSERT INTO @ContentVersions VALUES(@WorkId, NULL, NULL, NULL, NULL)
		SET @Index = @Index + 4
	END

	/* Add some meta data to temp table*/
	UPDATE @ContentVersions SET ContentID = tblContent.pkID, MasterVersionID = tblContentLanguage.Version, LanguageBranchID = tblWorkContent.fkLanguageBranchID, ContentTypeID = tblContent.fkContentTypeID
	FROM tblWorkContent INNER JOIN tblContent on tblWorkContent.fkContentID = tblContent.pkID
	INNER JOIN tblContentLanguage ON tblContentLanguage.fkContentID = tblContent.pkID
	WHERE tblWorkContent.pkID = VersionID AND tblWorkContent.fkLanguageBranchID = tblContentLanguage.fkLanguageBranchID

	/*Add master language version to support loading non localized props*/
	INSERT INTO @ContentVersions (ContentID, MasterVersionID, LanguageBranchID, ContentTypeID)
	SELECT DISTINCT tblContent.pkID, tblContentLanguage.Version, tblContentLanguage.fkLanguageBranchID, tblContent.fkContentTypeID 
	FROM @ContentVersions AS CV INNER JOIN tblContent ON CV.ContentID = tblContent.pkID
	INNER JOIN tblContentLanguage ON tblContent.pkID = tblContentLanguage.fkContentID
	WHERE tblContent.fkMasterLanguageBranchID = tblContentLanguage.fkLanguageBranchID

	/* Get all languages for all items*/
	SELECT DISTINCT ContentID AS PageLinkID, ContentTypeID as PageTypeID, tblContentLanguage.fkLanguageBranchID as PageLanguageBranchID 
	FROM @ContentVersions AS CV INNER JOIN tblContentLanguage ON CV.ContentID = tblContentLanguage.fkContentID
	WHERE CV.VersionID IS NOT NULL
	ORDER BY ContentID

	/* Get data for languages */
	SELECT
		W.Status AS PageWorkStatus,
		W.fkContentID AS PageLinkID,
		W.pkID AS PageLinkWorkID,
		W.LinkType AS PageShortcutType,
		W.ExternalURL AS PageExternalURL,
		W.ContentLinkGUID AS PageShortcutLinkID,
		W.Name AS PageName,
		W.URLSegment AS PageURLSegment,
		W.LinkURL AS PageLinkURL,
		W.BlobUri,
		W.ThumbnailUri,
		W.Created AS PageCreated,
		L.Changed AS PageChanged,
		W.Saved AS PageSaved,
		W.StartPublish AS PageStartPublish,
		W.StopPublish AS PageStopPublish,
		CASE WHEN L.Status = 4 THEN CAST(0 AS BIT) ELSE CAST(1 AS BIT) END AS PagePendingPublish,
		L.CreatorName AS PageCreatedBy,
		W.ChangedByName AS PageChangedBy,
		W.fkFrameID AS PageTargetFrame,
		W.ChangedOnPublish AS PageChangedOnPublish,
		CASE WHEN W.Status = 6 THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS  PageDelayedPublish,
		W.fkLanguageBranchID AS PageLanguageBranchID,
		W.DelayPublishUntil AS PageDelayPublishUntil
	FROM @ContentVersions AS CV
	INNER JOIN tblWorkContent AS W ON CV.VersionID = W.pkID 
	INNER JOIN tblContentLanguage AS L ON CV.ContentID = L.fkContentID
	WHERE 
		L.fkLanguageBranchID = W.fkLanguageBranchID

	ORDER BY L.fkContentID

	IF (@@ROWCOUNT = 0)
	BEGIN
		RETURN
	END

	/* Get common data for all versions of a content */
	SELECT
		CV.ContentID AS PageLinkID,
		CV.VersionID AS PageLinkWorkID,
		fkParentID  AS PageParentLinkID,
		fkContentTypeID AS PageTypeID,
		NULL AS PageTypeName,
		CONVERT(INT,VisibleInMenu) AS PageVisibleInMenu,
		ChildOrderRule AS PageChildOrderRule,
		0 AS PagePeerOrderRule,	-- No longer used
		PeerOrder AS PagePeerOrder,
		CONVERT(NVARCHAR(38),tblContent.ContentGUID) AS PageGUID,
		ArchiveContentGUID AS PageArchiveLinkID,
		ExternalFolderID AS PageFolderID,
		ContentAssetsID,
		ContentOwnerID,
		CONVERT(INT,Deleted) AS PageDeleted,
		DeletedBy AS PageDeletedBy,
		DeletedDate AS PageDeletedDate,
		fkMasterLanguageBranchID AS PageMasterLanguageBranchID,
		CreatorName
	FROM @ContentVersions AS CV
	INNER JOIN tblContent ON CV.ContentID = tblContent.pkID
	WHERE CV.VersionID IS NOT NULL
	ORDER BY CV.ContentID

	IF (@@ROWCOUNT = 0)
	BEGIN
		RETURN
	END
		
	
	/* Get the properties for the specific versions*/
	SELECT
		CV.ContentID AS PageLinkID,
		CV.VersionID AS PageLinkWorkID,
		tblPropertyDefinition.Name AS PropertyName,
		tblPropertyDefinition.pkID as PropertyDefinitionID,
		ScopeName,
		CONVERT(INT, Boolean) AS Boolean,
		Number AS IntNumber,
		FloatNumber,
		P.ContentType AS PageType,
		ContentLink AS PageLinkID,
		LinkGuid,	
		Date AS DateValue,
		String,
		LongString,
		CV.LanguageBranchID AS PageLanguageBranchID
	FROM tblWorkContentProperty AS P 
	INNER JOIN @ContentVersions AS CV ON P.fkWorkContentID = CV.VersionID 
	INNER JOIN tblPropertyDefinition ON tblPropertyDefinition.pkID = P.fkPropertyDefinitionID
	WHERE NOT tblPropertyDefinition.fkContentTypeID IS NULL
	ORDER BY CV.ContentID

	/* Get the non language specific properties from master language*/
	SELECT
		CV.ContentID AS PageLinkID,
		CV.VersionID AS PageLinkWorkID,
		tblPropertyDefinition.Name AS PropertyName,
		tblPropertyDefinition.pkID as PropertyDefinitionID,
		ScopeName,
		CONVERT(INT, Boolean) AS Boolean,
		Number AS IntNumber,
		FloatNumber,
		P.ContentType AS PageType,
		ContentLink AS PageLinkID,
		LinkGuid,	
		Date AS DateValue,
		String,
		LongString,
		CV.LanguageBranchID AS PageLanguageBranchID
	FROM tblWorkContentProperty AS P
	INNER JOIN tblWorkContent AS W ON P.fkWorkContentID = W.pkID
	INNER JOIN @ContentVersions AS CV ON W.fkContentID = CV.ContentID
	INNER JOIN tblPropertyDefinition ON tblPropertyDefinition.pkID = P.fkPropertyDefinitionID
	WHERE NOT tblPropertyDefinition.fkContentTypeID IS NULL AND
		P.fkWorkContentID = CV.MasterVersionID AND tblPropertyDefinition.LanguageSpecific<3
	ORDER BY CV.ContentID

	/*Get category information*/
	SELECT DISTINCT
		CV.ContentID AS PageLinkID,
		CV.VersionID AS PageLinkWorkID,
		fkCategoryID,
		CategoryType
	FROM tblWorkContentCategory
	INNER JOIN tblWorkContent ON tblWorkContentCategory.fkWorkContentID = tblWorkContent.pkID
	INNER JOIN @ContentVersions AS CV ON CV.ContentID = tblWorkContent.fkContentID 
	INNER JOIN @ContentVersions AS MasterVersion ON CV.ContentID = MasterVersion.ContentID
	WHERE CategoryType=0 AND (CV.VersionID = tblWorkContent.pkID OR
	(MasterVersion.VersionID IS NULL AND tblWorkContentCategory.fkWorkContentID = MasterVersion.MasterVersionID 
		AND MasterVersion.LanguageBranchID <> CV.LanguageBranchID))
	ORDER BY CV.ContentID,fkCategoryID

	/* Get access information */
	SELECT
		CV.ContentID AS PageLinkID,
		CV.VersionID AS PageLinkWorkID,
		tblContentAccess.Name,
		IsRole,
		AccessMask
	FROM
		@ContentVersions as CV
	INNER JOIN 
	    tblContentAccess ON ContentID=tblContentAccess.fkContentID
	ORDER BY
		fkContentID
END
GO
PRINT N'Creating [dbo].[editSetVersionStatus]...';


GO
CREATE PROCEDURE [dbo].[editSetVersionStatus]
(
	@WorkContentID INT,
	@Status INT,
	@UserName NVARCHAR(255),
	@Saved DATETIME = NULL,
	@RejectComment NVARCHAR(2000) = NULL,
	@DelayPublishUntil DateTime = NULL
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	UPDATE 
		tblWorkContent
	SET
		Status = @Status,
		NewStatusByName=@UserName,
		RejectComment= COALESCE(@RejectComment, RejectComment),
		Saved = COALESCE(@Saved, Saved),
		DelayPublishUntil = @DelayPublishUntil
	WHERE
		pkID=@WorkContentID 

	IF (@@ROWCOUNT = 0)
		RETURN 1

	-- If there is no published version for this language update published table as well
	DECLARE @ContentId INT;
	DECLARE @LanguageBranchID INT;

	SELECT @LanguageBranchID = lang.fkLanguageBranchID, @ContentId = lang.fkContentID FROM tblContentLanguage AS lang INNER JOIN tblWorkContent AS work 
		ON lang.fkContentID = work.fkContentID WHERE 
		work.pkID = @WorkContentID AND work.fkLanguageBranchID = lang.fkLanguageBranchID AND lang.Status <> 4

	IF @ContentId IS NOT NULL
		BEGIN

			UPDATE
				tblContentLanguage
			SET
				Status = @Status,
				DelayPublishUntil = @DelayPublishUntil
			WHERE
				fkContentID=@ContentID AND fkLanguageBranchID=@LanguageBranchID

		END

	RETURN 0
END
GO
PRINT N'Creating [dbo].[sp_FxDatabaseVersion]...';


GO
CREATE PROCEDURE dbo.sp_FxDatabaseVersion
AS
	RETURN 7000 --Note used since 7.5.500
GO
PRINT N'Creating [dbo].[EntityTypeGetNameByID]...';


GO
CREATE PROCEDURE dbo.EntityTypeGetNameByID
@intObjectTypeID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT strName FROM dbo.tblEntityType WHERE intID = @intObjectTypeID
END
GO
PRINT N'Creating [dbo].[EntityTypeGetIDByName]...';


GO
CREATE PROCEDURE dbo.EntityTypeGetIDByName
@strObjectType varchar(400)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @intID int
	SELECT @intID = intID FROM dbo.tblEntityType WHERE strName = @strObjectType

	IF @intID IS NULL
	BEGIN
		INSERT INTO dbo.tblEntityType (strName) VALUES(@strObjectType)

		SET @intID = SCOPE_IDENTITY()
	END

	SELECT @intID
END
GO
PRINT N'Creating [dbo].[EntitySetEntry]...';


GO
CREATE PROCEDURE dbo.EntitySetEntry
@intObjectTypeID int,
@intObjectID int,
@uniqueID uniqueidentifier
AS
BEGIN
	INSERT INTO tblEntityGuid
			(intObjectTypeID, intObjectID, unqID)
	VALUES
			(@intObjectTypeID, @intObjectID, @uniqueID)
END
GO
PRINT N'Creating [dbo].[EntityGetIdByGuidFromIdentity]...';


GO
CREATE PROCEDURE dbo.EntityGetIdByGuidFromIdentity
@uniqueID uniqueidentifier
AS
BEGIN
	SELECT tblBigTableStoreConfig.EntityTypeId as EntityTypeId, tblBigTableIdentity.pkId as ObjectId  
		FROM tblBigTableIdentity INNER JOIN tblBigTableStoreConfig 
		ON tblBigTableIdentity.StoreName = tblBigTableStoreConfig.StoreName
		WHERE tblBigTableIdentity.Guid = @uniqueID
END
GO
PRINT N'Creating [dbo].[EntityGetIDByGuid]...';


GO
CREATE PROCEDURE dbo.EntityGetIDByGuid
@unqID uniqueidentifier
AS
BEGIN
	SELECT 
		intObjectTypeID, intObjectID
	FROM tblEntityGuid
	WHERE unqID = @unqID
END
GO
PRINT N'Creating [dbo].[EntityGetGuidByIdFromIdentity]...';


GO
CREATE PROCEDURE dbo.EntityGetGuidByIdFromIdentity
@intObjectTypeID int,
@intObjectID int
AS
BEGIN
	SELECT Guid FROM tblBigTableIdentity INNER JOIN tblBigTableStoreConfig 
		ON tblBigTableIdentity.StoreName = tblBigTableStoreConfig.StoreName
		WHERE tblBigTableIdentity.pkId = @intObjectID AND
			tblBigTableStoreConfig.EntityTypeId = @intObjectTypeID
END
GO
PRINT N'Creating [dbo].[EntityGetGuidByID]...';


GO
CREATE PROCEDURE dbo.EntityGetGuidByID
@intObjectTypeID int,
@intObjectID int
AS
BEGIN
	SELECT unqID FROM tblEntityGuid WHERE intObjectTypeID = @intObjectTypeID AND intObjectID = @intObjectID
END
GO
PRINT N'Creating [dbo].[ChangeNotificationSetInvalidWorker]...';


GO
CREATE PROCEDURE [dbo].[ChangeNotificationSetInvalidWorker]
    @processorId uniqueidentifier,
    @inactiveConnectionTimeoutSeconds int
as
begin
    delete from tblChangeNotificationQueuedInt where ProcessorId = @processorId
    delete from tblChangeNotificationQueuedGuid where ProcessorId = @processorId
    delete from tblChangeNotificationQueuedString where ProcessorId = @processorId

    update tblChangeNotificationProcessor
    set ProcessorStatus = 'invalid', NextQueueOrderValue = 0, LastConsistentDbUtc = null
    where ProcessorId = @processorId

    delete from tblChangeNotificationConnection
    where ProcessorId = @processorId and LastActivityDbUtc < DATEADD(second, -@inactiveConnectionTimeoutSeconds, GETUTCDATE())

    update tblChangeNotificationConnection
    set IsOpen = 1
    where ProcessorId = @processorId and IsOpen = 0
end
GO
PRINT N'Creating [dbo].[ChangeNotificationSetInvalid]...';


GO
CREATE PROCEDURE [dbo].[ChangeNotificationSetInvalid]
    @processorId uniqueidentifier,
    @inactiveConnectionTimeoutSeconds int
as
begin
    begin try
        begin transaction
        exec ChangeNotificationSetInvalidWorker @processorId, @inactiveConnectionTimeoutSeconds
        commit transaction
    end try
    begin catch
    declare @msg nvarchar(4000), @sev int, @stt int
        select @msg = ERROR_MESSAGE(), @sev = ERROR_SEVERITY(), @stt = ERROR_STATE()

        rollback transaction
        raiserror(@msg, @sev, @stt)
    end catch
end
GO
PRINT N'Creating [dbo].[ChangeNotificationOpenConnection]...';


GO
CREATE PROCEDURE [dbo].[ChangeNotificationOpenConnection]
    @processorId uniqueidentifier,
    @queuedDataType nvarchar(30),
    @processorName nvarchar(4000),
    @inactiveConnectionTimeoutSeconds int
as
begin
    declare @connectionId uniqueidentifier
    declare @processorStatus nvarchar(30)
    declare @configuredChangeNotificationDataType nvarchar(30)

    begin try
        begin transaction

        declare @utcnow datetime = GETUTCDATE()

        select @processorStatus = ProcessorStatus, @configuredChangeNotificationDataType = ChangeNotificationDataType
        from tblChangeNotificationProcessor
        where ProcessorId = @processorId

        if (@processorStatus is null)
        begin
            -- the queue does not exist on the database yet. create and open with state invalid.
            set @processorStatus = 'invalid'

            insert into tblChangeNotificationProcessor (ProcessorId, ChangeNotificationDataType, ProcessorName, ProcessorStatus, NextQueueOrderValue)
            values (@processorId, @queuedDataType, @processorName, @processorStatus, 0)

            set @connectionId = NEWID()
            insert into tblChangeNotificationConnection (ProcessorId, ConnectionId, IsOpen, LastActivityDbUtc)
            values (@processorId, @connectionId, 1, @utcnow)
        end
        else if (@processorStatus = 'invalid' or exists (select 1
            from tblChangeNotificationConnection
            where ProcessorId = @processorId and LastActivityDbUtc < DATEADD(second, -@inactiveConnectionTimeoutSeconds, @utcnow)))
        begin
            -- the queue exists.  we can skip waiting for another running processor to confirm the state, since it is invalid anyways.
            exec ChangeNotificationSetInvalidWorker @processorId, @inactiveConnectionTimeoutSeconds

            set @connectionId = NEWID()
            insert into tblChangeNotificationConnection (ProcessorId, ConnectionId, IsOpen, LastActivityDbUtc)
            values (@processorId, @connectionId, 1, @utcnow)
        end
        else if (@queuedDataType = @configuredChangeNotificationDataType)
        begin
            set @connectionId = NEWID()
            declare @isOpen bit

            if exists (select 1 from tblChangeNotificationConnection where ProcessorId = @processorId)
            begin
                -- there are connections open, which may or may not still be running.
                -- leave the isOpen flag set to 0 as a request for a running process to confirm the queue status.
                set @isOpen = 0
            end
            else
            begin
                -- there are no connections to the queue. open with the current status intact.
                set @isOpen = 1
            end

            insert into tblChangeNotificationConnection (ProcessorId, ConnectionId, IsOpen, LastActivityDbUtc)
            values (@processorId, @connectionId, @isOpen, GETUTCDATE())
        end
        else
        begin
            -- the processor exists with a different queued type. throw an exception.
            raiserror('The specified processor ID already exists with a different queued type.', 16, 1)
        end

        select c.ConnectionId, case when c.IsOpen = 0 then 'opening' else p.ProcessorStatus end as ProcessorStatus
        from tblChangeNotificationConnection c
        join tblChangeNotificationProcessor p on c.ProcessorId = p.ProcessorId
        where c.ConnectionId = @connectionId

        commit transaction
    end try
    begin catch
        declare @msg nvarchar(4000), @sev int, @stt int
        select @msg = ERROR_MESSAGE(), @sev = ERROR_SEVERITY(), @stt = ERROR_STATE()

        rollback transaction
        raiserror(@msg, @sev, @stt)
    end catch
end
GO
PRINT N'Creating [dbo].[ChangeNotificationEnqueueString]...';


GO
CREATE PROCEDURE [dbo].[ChangeNotificationEnqueueString]
    @processorId uniqueidentifier,
    @items ChangeNotificationStringTable readonly
as
begin
    begin try
        begin transaction

        declare @processorStatus nvarchar(30)
        select @processorStatus = ProcessorStatus
        from tblChangeNotificationProcessor
        where ProcessorId = @processorId

        if (@processorStatus != 'invalid' and @processorStatus != 'closed')
        begin
            declare @queueOrder int
            update tblChangeNotificationProcessor
            set @queueOrder = NextQueueOrderValue = NextQueueOrderValue + 1, LastConsistentDbUtc = case when @processorStatus = 'valid' and NextQueueOrderValue = 0 then GETUTCDATE() else LastConsistentDbUtc end
            where ProcessorId = @processorId

            -- insert values from @items, avoiding any values which are already in the queue and not in an outstanding batch.
            insert into tblChangeNotificationQueuedString (ProcessorId, QueueOrder, ConnectionId, Value)
            select @processorId, @queueOrder, null, i.Value
            from @items i
            left outer join tblChangeNotificationQueuedString q
                on q.ProcessorId = @processorId
                and q.ConnectionId is null
                and i.Value = q.Value
            where q.ProcessorId is null
        end

        commit transaction
    end try
    begin catch
        declare @msg nvarchar(4000), @sev int, @stt int
        select @msg = ERROR_MESSAGE(), @sev = ERROR_SEVERITY(), @stt = ERROR_STATE()

        rollback transaction
        raiserror(@msg, @sev, @stt)
    end catch
end
GO
PRINT N'Creating [dbo].[ChangeNotificationEnqueueInt]...';


GO
CREATE PROCEDURE [dbo].[ChangeNotificationEnqueueInt]
    @processorId uniqueidentifier,
    @items ChangeNotificationIntTable readonly
as
begin
    begin try
        begin transaction

        declare @processorStatus nvarchar(30)
        select @processorStatus = ProcessorStatus
        from tblChangeNotificationProcessor
        where ProcessorId = @processorId

        if (@processorStatus != 'invalid' and @processorStatus != 'closed')
        begin
            declare @queueOrder int
            update tblChangeNotificationProcessor
            set @queueOrder = NextQueueOrderValue = NextQueueOrderValue + 1, LastConsistentDbUtc = case when @processorStatus = 'valid' and NextQueueOrderValue = 0 then GETUTCDATE() else LastConsistentDbUtc end
            where ProcessorId = @processorId

            -- insert values from @items, avoiding any values which are already in the queue and not in an outstanding batch.
            insert into tblChangeNotificationQueuedInt (ProcessorId, QueueOrder, ConnectionId, Value)
            select @processorId, @queueOrder, null, i.Value
            from @items i
            left outer join tblChangeNotificationQueuedInt q
                on q.ProcessorId = @processorId
                and q.ConnectionId is null
                and i.Value = q.Value
            where q.ProcessorId is null
        end

        commit transaction
    end try
    begin catch
        declare @msg nvarchar(4000), @sev int, @stt int
        select @msg = ERROR_MESSAGE(), @sev = ERROR_SEVERITY(), @stt = ERROR_STATE()

        rollback transaction
        raiserror(@msg, @sev, @stt)
    end catch
end
GO
PRINT N'Creating [dbo].[ChangeNotificationEnqueueGuid]...';


GO
CREATE PROCEDURE [dbo].[ChangeNotificationEnqueueGuid]
    @processorId uniqueidentifier,
    @items ChangeNotificationGuidTable readonly
as
begin
    begin try
        begin transaction

        declare @processorStatus nvarchar(30)
        select @processorStatus = ProcessorStatus
        from tblChangeNotificationProcessor
        where ProcessorId = @processorId

        if (@processorStatus != 'invalid' and @processorStatus != 'closed')
        begin
            declare @queueOrder int
            update tblChangeNotificationProcessor
            set @queueOrder = NextQueueOrderValue = NextQueueOrderValue + 1, LastConsistentDbUtc = case when @processorStatus = 'valid' and NextQueueOrderValue = 0 then GETUTCDATE() else LastConsistentDbUtc end
            where ProcessorId = @processorId

            -- insert values from @items, avoiding any values which are already in the queue and not in an outstanding batch.
            insert into tblChangeNotificationQueuedGuid (ProcessorId, QueueOrder, ConnectionId, Value)
            select @processorId, @queueOrder, null, i.Value
            from @items i
            left outer join tblChangeNotificationQueuedGuid q
                on q.ProcessorId = @processorId
                and q.ConnectionId is null
                and i.Value = q.Value
            where q.ProcessorId is null
        end

        commit transaction
    end try
    begin catch
        declare @msg nvarchar(4000), @sev int, @stt int
        select @msg = ERROR_MESSAGE(), @sev = ERROR_SEVERITY(), @stt = ERROR_STATE()

        rollback transaction
        raiserror(@msg, @sev, @stt)
    end catch
end
GO
PRINT N'Creating [dbo].[ChangeNotificationCloseConnection]...';


GO
CREATE PROCEDURE [dbo].[ChangeNotificationCloseConnection]
    @connectionId uniqueidentifier
as
begin
    begin try
        begin transaction

        declare @processorId uniqueidentifier
        declare @processorStatus nvarchar(30)
        select @processorId = p.ProcessorId, @processorStatus = p.ProcessorStatus
        from tblChangeNotificationConnection c
        join tblChangeNotificationProcessor p on c.ProcessorId = p.ProcessorId
        where c.ConnectionId = @connectionId

        update tblChangeNotificationQueuedInt set ConnectionId = null where ConnectionId = @connectionId
        update tblChangeNotificationQueuedGuid set ConnectionId = null where ConnectionId = @connectionId
        update tblChangeNotificationQueuedString set ConnectionId = null where ConnectionId = @connectionId
        delete from tblChangeNotificationConnection where ConnectionId = @connectionId

        if (@processorStatus != 'valid' and not exists (select 1 from tblChangeNotificationConnection where ProcessorId = @processorId))
        begin
            -- if there are no connections to the queue and it is not in a valid state, remove it from persistent storage.
            delete from tblChangeNotificationQueuedInt where ProcessorId = @processorId
            delete from tblChangeNotificationQueuedGuid where ProcessorId = @processorId
            delete from tblChangeNotificationQueuedString where ProcessorId = @processorId
            delete from tblChangeNotificationProcessor where ProcessorId = @processorId
        end

        commit transaction

        select @connectionId as ConnectionId
    end try
    begin catch
        declare @msg nvarchar(4000), @sev int, @stt int
        select @msg = ERROR_MESSAGE(), @sev = ERROR_SEVERITY(), @stt = ERROR_STATE()

        rollback transaction
        raiserror(@msg, @sev, @stt)
    end catch
end
GO
PRINT N'Creating [dbo].[ChangeNotificationAccessConnectionWorker]...';


GO
CREATE PROCEDURE [dbo].[ChangeNotificationAccessConnectionWorker]
    @connectionId uniqueidentifier,
    @expectedChangeNotificationDataType nvarchar(30) = null
as
begin
    update tblChangeNotificationConnection
    set LastActivityDbUtc = GETUTCDATE()
    where ConnectionId = @connectionId

    declare @processorId uniqueidentifier
    declare @queuedDataType nvarchar(30)
    declare @processorStatus nvarchar(30)
    declare @nextQueueOrderValue int
    declare @lastConsistentDbUtc datetime
    declare @isOpen bit
    select @processorId = p.ProcessorId, @queuedDataType = p.ChangeNotificationDataType, @processorStatus = p.ProcessorStatus, @nextQueueOrderValue = p.NextQueueOrderValue, @lastConsistentDbUtc = p.LastConsistentDbUtc, @isOpen = c.IsOpen
    from tblChangeNotificationProcessor p
    join tblChangeNotificationConnection c on p.ProcessorId = c.ProcessorId
    where c.ConnectionId = @connectionId

    if (@processorId is null)
    begin
        set @processorStatus = 'closed'
    end
    else if (@expectedChangeNotificationDataType is not null and @expectedChangeNotificationDataType != @queuedDataType)
    begin
        set @processorStatus = 'type_mismatch'
    end
    else if (@processorStatus = 'invalid' or @isOpen = 1)
    begin
        -- the queue is invalid, or the current connection is valid.
        -- all pending connection requests may be considered open.
        update tblChangeNotificationConnection
        set IsOpen = 1
        where ProcessorId = @processorId and IsOpen = 0

        if (@processorStatus = 'valid' and @nextQueueOrderValue = 0)
        begin
            set @lastConsistentDbUtc = GETUTCDATE()
        end
    end
    else if (@isOpen = 0 and @processorStatus != 'invalid')
    begin
        set @processorStatus = 'opening'
    end

    select @processorId as ProcessorId,  @processorStatus as ProcessorStatus, @lastConsistentDbUtc
end
GO
PRINT N'Creating [dbo].[BigTableSaveReference]...';


GO
CREATE PROCEDURE [dbo].[BigTableSaveReference]
	@Id bigint,
	@Type int,
	@PropertyName nvarchar(75),
	@CollectionType nvarchar(2000) = NULL,
	@ElementType nvarchar(2000) = NULL,
	@ElementStoreName nvarchar(375) = null,
	@IsKey bit,
	@Index int,
	@BooleanValue bit = NULL,
	@IntegerValue int = NULL,
	@LongValue bigint = NULL,
	@DateTimeValue datetime = NULL,
	@GuidValue uniqueidentifier = NULL,
	@FloatValue float = NULL,	
	@StringValue nvarchar(max) = NULL,
	@BinaryValue varbinary(max) = NULL,
	@RefIdValue bigint = NULL,
	@ExternalIdValue bigint = NULL,
	@DecimalValue decimal(18, 3) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	if not exists(select * from tblBigTableReference where pkId = @Id and PropertyName = @PropertyName and IsKey = @IsKey and [Index] = @Index)
	begin
		-- insert
		insert into tblBigTableReference
		values
		(
			@Id,
			@Type,
			@PropertyName,
			@CollectionType,
			@ElementType,
			@ElementStoreName,
			@IsKey,
			@Index,
			@BooleanValue,
			@IntegerValue,
			@LongValue,
			@DateTimeValue,
			@GuidValue,
			@FloatValue,
			@StringValue,
			@BinaryValue,
			@RefIdValue,
			@ExternalIdValue,
			@DecimalValue
		)
	end
	else
	begin
		-- update
		update tblBigTableReference
		set
		CollectionType = @CollectionType,
		ElementType = @ElementType,
		ElementStoreName  = @ElementStoreName,
		BooleanValue = @BooleanValue,
		IntegerValue = @IntegerValue,
		LongValue = @LongValue,
		DateTimeValue = @DateTimeValue,
		GuidValue = @GuidValue,
		FloatValue = @FloatValue,
		StringValue = @StringValue,
		BinaryValue = @BinaryValue,
		RefIdValue = @RefIdValue,
		ExternalIdValue = @ExternalIdValue,
		DecimalValue = @DecimalValue
		where
		pkId = @Id and PropertyName = @PropertyName and IsKey = @IsKey and [Index] = @Index
	end   
END
GO
PRINT N'Creating [dbo].[BigTableDeleteItemInternal]...';


GO
CREATE PROCEDURE [dbo].[BigTableDeleteItemInternal]
@forceDelete bit = 0
AS
BEGIN

	DECLARE @nestLevel int
	SET @nestLevel = 1

	WHILE @@ROWCOUNT > 0
	BEGIN
	
		SET @nestLevel = @nestLevel + 1

		-- insert all items contained in the ones matching the _previous_ nestlevel and give them _this_ nestLevel
		-- exclude those items that are also referred by some other item not already in #deletes
		-- IMPORTANT: Make sure that this insert is the last statement that can affect @@ROWCOUNT in the while-loop
		INSERT INTO #deletes(Id, NestLevel, ObjectPath)
		SELECT DISTINCT RefIdValue, @nestLevel, #deletes.ObjectPath + '/' + CAST(RefIdValue AS VARCHAR) + '/'
		FROM tblBigTableReference R1
		INNER JOIN #deletes ON #deletes.Id=R1.pkId
		WHERE #deletes.NestLevel=@nestLevel-1
		AND RefIdValue NOT IN(SELECT Id FROM #deletes)

	END 

	DELETE #deletes FROM #deletes
	INNER JOIN 
	(
		SELECT innerDelete.Id
		FROM #deletes as innerDelete
		INNER JOIN tblBigTableReference ON tblBigTableReference.RefIdValue=innerDelete.Id
		WHERE NOT EXISTS(SELECT * FROM #deletes WHERE #deletes.Id=tblBigTableReference.pkId)
	) ReferencedObjects ON #deletes.ObjectPath LIKE '%/' + CAST(ReferencedObjects.Id AS VARCHAR) + '/%'
	WHERE @forceDelete = 0 OR #deletes.NestLevel > 1

	BEGIN TRAN
	 
		DELETE FROM tblBigTableReference WHERE RefIdValue in (SELECT Id FROM #deletes)
		DELETE FROM tblBigTableReference WHERE pkId in (SELECT Id FROM #deletes)

		-- Go through each big table and delete any rows associated with the item being deleted
		DECLARE @tableName NVARCHAR(128)

		DECLARE tableNameCursor CURSOR READ_ONLY 
		FOR SELECT DISTINCT TableName FROM tblBigTableStoreConfig WHERE TableName IS NOT NULL				
		OPEN tableNameCursor

		FETCH NEXT FROM tableNameCursor INTO @tableName

		WHILE @@FETCH_STATUS = 0
		BEGIN

			EXEC ('DELETE FROM ' + @tableName  +  ' WHERE pkId in (SELECT Id FROM #deletes)')
			FETCH NEXT FROM tableNameCursor INTO @tableName

		END

		CLOSE tableNameCursor
		DEALLOCATE tableNameCursor 			
		 
		DELETE FROM tblBigTableIdentity WHERE pkId in (SELECT Id FROM #deletes)
		 
	COMMIT TRAN
END
GO
PRINT N'Creating [dbo].[BigTableDeleteItem]...';


GO
CREATE PROCEDURE [dbo].[BigTableDeleteItem]
@StoreId BIGINT = NULL,
@ExternalId uniqueidentifier = NULL
AS
BEGIN

	IF @StoreId IS NULL
	BEGIN
		SELECT @StoreId = pkId FROM tblBigTableIdentity WHERE [Guid] = @ExternalId
	END

	IF @StoreId IS NULL RAISERROR(N'No object exists for the unique identifier passed', 1, 1)

	CREATE TABLE #deletes(Id BIGINT, NestLevel INT, ObjectPath varchar(max))
	CREATE INDEX IX_Deletes_Id ON #deletes(Id)
	CREATE INDEX IX_Deletes_Id_NestLevel ON #deletes(Id, NestLevel)
	
	INSERT INTO #deletes(Id, NestLevel, ObjectPath) VALUES(@StoreId, 1, '/' + CAST(@StoreId AS varchar) + '/')
	EXEC ('BigTableDeleteItemInternal')

	DROP INDEX IX_Deletes_Id_NestLevel ON #deletes
	DROP INDEX IX_Deletes_Id ON #deletes
	DROP TABLE #deletes
END
GO
PRINT N'Creating [dbo].[BigTableDeleteExcessReferences]...';


GO
CREATE PROCEDURE [dbo].[BigTableDeleteExcessReferences]
	@Id bigint,
	@PropertyName nvarchar(75),
	@StartIndex int
AS
BEGIN

BEGIN TRAN
	IF @StartIndex > -1
	BEGIN

		-- Creates temporary store with id's of references that has no other reference
		CREATE TABLE #deletes(Id BIGINT, NestLevel INT, ObjectPath varchar(max))
		CREATE INDEX IX_Deletes_Id ON #deletes(Id)
		CREATE INDEX IX_Deletes_Id_NestLevel ON #deletes(Id, NestLevel)
		
		INSERT INTO #deletes(Id, NestLevel, ObjectPath)
		SELECT DISTINCT R1.RefIdValue, 1, '/' + CAST(R1.RefIdValue AS VARCHAR) + '/' FROM tblBigTableReference AS R1
		LEFT OUTER JOIN tblBigTableReference AS R2 ON R1.RefIdValue = R2.pkId
		WHERE R1.pkId = @Id AND R1.PropertyName = @PropertyName AND R1.[Index] >= @StartIndex AND 
				R1.RefIdValue IS NOT NULL AND R2.RefIdValue IS NULL
		
		-- Remove reference on main store
		DELETE FROM tblBigTableReference WHERE pkId = @Id and PropertyName = @PropertyName and [Index] >= @StartIndex
		
		IF((select count(*) from #deletes) > 0)
		BEGIN
			EXEC ('BigTableDeleteItemInternal')
		END

		DROP INDEX IX_Deletes_Id_NestLevel ON #deletes
		DROP INDEX IX_Deletes_Id ON #deletes
		DROP TABLE #deletes
	
	END
	ELSE
		-- Remove reference on main store
		DELETE FROM tblBigTableReference WHERE pkId = @Id and PropertyName = @PropertyName and [Index] >= @StartIndex

COMMIT TRAN
END
GO
PRINT N'Creating [dbo].[BigTableDeleteAll]...';


GO
CREATE PROCEDURE [dbo].[BigTableDeleteAll]
@ViewName nvarchar(4000)
AS
BEGIN
	CREATE TABLE #deletes(Id BIGINT, NestLevel INT, ObjectPath varchar(max))
	CREATE INDEX IX_Deletes_Id ON #deletes(Id)
	CREATE INDEX IX_Deletes_Id_NestLevel ON #deletes(Id, NestLevel)
	
	INSERT INTO #deletes(Id, NestLevel, ObjectPath)
	EXEC ('SELECT [StoreId], 1, ''/'' + CAST([StoreId] AS VARCHAR) + ''/'' FROM ' + @ViewName)
	

	EXEC ('BigTableDeleteItemInternal 1')

	DROP INDEX IX_Deletes_Id_NestLevel ON #deletes
	DROP INDEX IX_Deletes_Id ON #deletes
	DROP TABLE #deletes

END
GO
PRINT N'Creating [dbo].[TestClearItems]...';


GO
CREATE PROCEDURE dbo.TestClearItems
AS
BEGIN
	DELETE FROM tblIndexString
	DELETE FROM tblIndexInt
	DELETE FROM tblIndexDateTime
	DELETE FROM tblIndexDecimal
	DELETE FROM tblIndexFloat
	DELETE FROM tblIndexGuid
	DELETE FROM tblRelation
	DELETE FROM tblItem
	DELETE FROM tblSchema
END
GO
PRINT N'Creating [dbo].[sp_DatabaseVersion]...';


GO
CREATE PROCEDURE [dbo].[sp_DatabaseVersion]
AS
	RETURN 7012
GO
PRINT N'Creating [dbo].[SchemaSave]...';


GO
CREATE PROCEDURE  dbo.SchemaSave
(
	@SchemaId	NVARCHAR(256),
	@IdType		NVARCHAR(256)
)
AS
BEGIN
	DECLARE @Id INT
		
	SELECT @Id=pkID FROM tblSchema WHERE SchemaId=@SchemaId
	
	IF (@@ROWCOUNT = 0)
	BEGIN
		INSERT INTO tblSchema 
			([SchemaId], [IdType]) 
		VALUES 
			(@SchemaId, @IdType)
		SET @Id =  SCOPE_IDENTITY() 
	END
	
	RETURN @Id
END
GO
PRINT N'Creating [dbo].[SchemaLoad]...';


GO
CREATE PROCEDURE dbo.SchemaLoad
	@SchemaId	NVARCHAR(256)
AS
BEGIN
	SELECT
		[tblSchemaItem].[pkID] AS SchemaItemId,
		[FieldName],
		[FieldType],
		[Indexed]
	FROM 
		tblSchemaItem
	INNER JOIN
		tblSchema ON fkSchemaId=tblSchema.pkID
	WHERE
		SchemaId=@SchemaId
END
GO
PRINT N'Creating [dbo].[SchemaList]...';


GO
CREATE PROCEDURE dbo.SchemaList
AS
BEGIN
	SELECT
		[pkID] AS DatabaseSchemaId,
		[SchemaId],
		[IdType]
	FROM 
		tblSchema
	ORDER BY
		[SchemaId]
END
GO
PRINT N'Creating [dbo].[SchemaItemSave]...';


GO
CREATE PROCEDURE dbo.SchemaItemSave
(
	@SchemaId	NVARCHAR(256),
	@FieldName	NVARCHAR(256),
	@FieldType	NVARCHAR(256),
	@Indexed	INT
)
AS
BEGIN
	DECLARE @fkSchemaId INT
	DECLARE @SchemaItemId INT
	
	SELECT @fkSchemaId=pkID FROM tblSchema WHERE [SchemaId]=@SchemaId
	IF (@@ROWCOUNT = 0)
		RAISERROR('Schema %s does not exist.', 16, 1, @SchemaId)
		
	SELECT @SchemaItemId=pkID FROM tblSchemaItem WHERE fkSchemaId=@fkSchemaId AND FieldName=@FieldName
	IF (@@ROWCOUNT = 0)
	BEGIN
		INSERT INTO tblSchemaItem 
			(fkSchemaId,
			FieldName,
			FieldType,
			Indexed)
		VALUES
			(@fkSchemaId,
			@FieldName,
			@FieldType,
			@Indexed)
		SET @SchemaItemId = SCOPE_IDENTITY() 
	END
	ELSE
	BEGIN
		UPDATE tblSchemaItem SET
			FieldType=@FieldType,
			Indexed=@Indexed
		WHERE
			pkID=@SchemaItemId
	END
	
	RETURN @SchemaItemId
END
GO
PRINT N'Creating [dbo].[SchemaDelete]...';


GO
CREATE PROCEDURE dbo.SchemaDelete
(
	@SchemaId	NVARCHAR(256)
)
AS
BEGIN
	DELETE FROM tblSchema WHERE [SchemaId]=@SchemaId
END
GO
PRINT N'Creating [dbo].[RelationRemove]...';


GO
CREATE PROCEDURE dbo.RelationRemove
(
	@FromId	NVARCHAR(100),
	@ToId NVARCHAR(100)
)
AS
BEGIN
	DELETE FROM tblRelation WHERE FromId=@FromId AND ToId=@ToId
END
GO
PRINT N'Creating [dbo].[RelationListTo]...';


GO
CREATE PROCEDURE [dbo].[RelationListTo]
(
	@ToId	NVARCHAR(100),
	@SchemaId	INT = 0
)
AS
BEGIN
	SELECT FromId AS Id
	FROM tblRelation
	JOIN tblItem ON tblRelation.FromId = tblItem.pkID
	WHERE tblRelation.ToId=@ToId
	AND ( tblItem.fkSchemaId = @SchemaId OR @SchemaId = 0)
END
GO
PRINT N'Creating [dbo].[RelationListFrom]...';


GO
CREATE PROCEDURE [dbo].[RelationListFrom]
(
	@FromId		NVARCHAR(100),
	@SchemaId	INT = 0
)
AS
BEGIN
	SELECT ToId AS Id
	FROM tblRelation
	JOIN tblItem ON tblRelation.ToId = tblItem.pkID
	WHERE tblRelation.FromId=@FromId
	AND ( tblItem.fkSchemaId = @SchemaId OR @SchemaId = 0)
END
GO
PRINT N'Creating [dbo].[RelationAdd]...';


GO
CREATE PROCEDURE [dbo].[RelationAdd]
(
	@FromId	NVARCHAR(100),
	@ToId NVARCHAR(100)
)
AS
BEGIN
	DECLARE @Name NVARCHAR(256)
	SELECT @Name=[Name] FROM tblItem WHERE pkID=@ToId
	IF (@Name IS NULL)
	BEGIN
		INSERT INTO tblRelation (FromId, ToId) VALUES (@FromId,@ToId)
		RETURN
	END
	IF (EXISTS(SELECT * FROM tblRelation WHERE ToName=@Name AND FromId=@FromId))
	BEGIN
		RAISERROR('Item with name %s already exists on same level.', 16, 1, @Name)
		RETURN
	END
	INSERT INTO tblRelation (FromId, ToId,ToName) VALUES (@FromId,@ToId,@Name)
END
GO
PRINT N'Creating [dbo].[netWinRolesUserList]...';


GO
CREATE PROCEDURE dbo.netWinRolesUserList 
(
	@GroupName NVARCHAR(255),
	@UserNameToMatch NVARCHAR(255) = NULL
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	DECLARE @GroupID INT
	SELECT 
	    @GroupID=pkID
	FROM
	    tblWindowsGroup
	WHERE
	    LoweredGroupName=LOWER(@GroupName)
	IF (@GroupID IS NULL)
	BEGIN
	    RETURN -1   /* Role does not exist */
	END
	
	SELECT
	    UserName
	FROM
	    tblWindowsRelations AS WR
	INNER JOIN
	    tblWindowsUser AS WU
	ON
	    WU.pkID=WR.fkWindowsUser
	WHERE
	    WR.fkWindowsGroup=@GroupID AND
	    ((WU.LoweredUserName LIKE LOWER(@UserNameToMatch)) OR (@UserNameToMatch IS NULL))
END
GO
PRINT N'Creating [dbo].[netWinRolesList]...';


GO
CREATE PROCEDURE dbo.netWinRolesList 
(
	@GroupName NVARCHAR(255) = NULL
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
    SELECT
        GroupName
    FROM
        tblWindowsGroup
    WHERE
		Enabled = 1 AND
        ((@GroupName IS NULL) OR
        (LoweredGroupName LIKE LOWER(@GroupName)))
    ORDER BY
        GroupName     
END
GO
PRINT N'Creating [dbo].[netWinRolesGroupInsert]...';


GO
CREATE PROCEDURE dbo.netWinRolesGroupInsert 
(
	@GroupName NVARCHAR(255)
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON

	DECLARE @LoweredName NVARCHAR(255)

    /* Check if group exists, insert it if not */
	SET @LoweredName=LOWER(@GroupName)
    INSERT INTO tblWindowsGroup
        (GroupName, 
		LoweredGroupName)
	SELECT
	    @GroupName,
	    @LoweredName
	WHERE NOT EXISTS(SELECT pkID FROM tblWindowsGroup WHERE LoweredGroupName=@LoweredName)
	
    /* Inserted group, return the id */
    IF (@@ROWCOUNT > 0)
    BEGIN
        RETURN  SCOPE_IDENTITY() 
    END
	
	DECLARE @GroupID INT
	SELECT @GroupID=pkID FROM tblWindowsGroup WHERE LoweredGroupName=@LoweredName

	RETURN @GroupID
END
GO
PRINT N'Creating [dbo].[netWinRolesGroupDelete]...';


GO
CREATE PROCEDURE dbo.netWinRolesGroupDelete
(
	@GroupName NVARCHAR(255),
	@ForceDelete INT
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	DECLARE @GroupID INT
	DECLARE @LoweredName NVARCHAR(255)

    /* Check if group exists */
	SET @LoweredName=LOWER(@GroupName)
	SET @GroupID=NULL
	SELECT
		@GroupID = pkID
	FROM
		tblWindowsGroup
	WHERE
		LoweredGroupName=@LoweredName
	
	/* Group does not exist - do nothing */	
    IF (@GroupID IS NULL)
    BEGIN
        RETURN 0
    END
    
    IF (@ForceDelete = 0)
    BEGIN
        IF (EXISTS(SELECT fkWindowsGroup FROM tblWindowsRelations WHERE fkWindowsGroup=@GroupID))
        BEGIN
            RETURN 1    /* Indicate failure - no force delete and group is populated */
        END
    END
    
    DELETE FROM
        tblWindowsRelations
    WHERE
        fkWindowsGroup=@GroupID

    DELETE FROM
        tblWindowsGroup
    WHERE
        pkID=@GroupID
        
    RETURN 0
END
GO
PRINT N'Creating [dbo].[netWinMembershipListUsers]...';


GO
CREATE PROCEDURE dbo.netWinMembershipListUsers
(
	@UserNameToMatch NVARCHAR(255) = NULL
)
AS
BEGIN
	SET NOCOUNT ON
	SET @UserNameToMatch = LOWER(@UserNameToMatch)
	SELECT
		UserName
	FROM
		tblWindowsUser
	WHERE
	    (tblWindowsUser.LoweredUserName LIKE @UserNameToMatch) OR (@UserNameToMatch IS NULL)
	ORDER BY UserName
END
GO
PRINT N'Creating [dbo].[netWinMembershipGroupList]...';


GO
CREATE PROCEDURE dbo.netWinMembershipGroupList 
(
    @UserID INT OUT,
	@UserName NVARCHAR(255)
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON

	DECLARE @LoweredName NVARCHAR(255)

	/* Get the id for the user name */
	SET @LoweredName=LOWER(@UserName)
	SELECT 
		@UserID=pkID 
	FROM
		tblWindowsUser
	WHERE
		LoweredUserName=@LoweredName

    /* Get Group name and id */
    SELECT
        GroupName,
        fkWindowsGroup AS GroupID
    FROM
        tblWindowsRelations AS WR
    INNER JOIN
        tblWindowsGroup AS WG
    ON
        WR.fkWindowsGroup=WG.pkID
    WHERE
        WR.fkWindowsUser=@UserID
    ORDER BY
        GroupName
END
GO
PRINT N'Creating [dbo].[netWinMembershipGroupInsert]...';


GO
CREATE PROCEDURE dbo.netWinMembershipGroupInsert 
(
	@UserID INT OUT,
	@UserName NVARCHAR(255),
	@GroupName NVARCHAR(255)
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON

	DECLARE @GroupID INT
	DECLARE @LoweredName NVARCHAR(255)

	IF (@UserID IS NULL)
	BEGIN
		/* Get the id for the user name */
		SET @LoweredName=LOWER(@UserName)
		INSERT INTO tblWindowsUser 
			(UserName, 
			LoweredUserName) 
		SELECT 
			@UserName, 
			@LoweredName
		WHERE NOT EXISTS (SELECT pkID FROM tblWindowsUser WHERE LoweredUserName=@LoweredName)
		
		IF (@@ROWCOUNT > 0)
		BEGIN
		    SET @UserID= SCOPE_IDENTITY() 
		END
		ELSE
		BEGIN
		    SELECT @UserID=pkID FROM tblWindowsUser WHERE LoweredUserName=@LoweredName
		END
	END

	/* We have a valid UserID, now get the group id */
	EXEC @GroupID=netWinRolesGroupInsert @GroupName=@GroupName
	IF (@GroupID IS NULL)
	BEGIN
		RAISERROR(50001, 14, 1)
	END

	/* We now have a valid role id and user id, add to relations table */
	INSERT INTO tblWindowsRelations
		(fkWindowsUser,
		fkWindowsGroup)
	SELECT 
		@UserID,
		@GroupID
	WHERE NOT EXISTS (SELECT fkWindowsUser FROM tblWindowsRelations WHERE fkWindowsUser=@UserID AND fkWindowsGroup=@GroupID)
END
GO
PRINT N'Creating [dbo].[netWinMembershipGroupDelete]...';


GO
CREATE PROCEDURE dbo.netWinMembershipGroupDelete 
(
	@UserID INT OUT,
	@UserName NVARCHAR(255),
	@GroupName NVARCHAR(255)
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT OFF

	DECLARE @ErrorVal INT
	DECLARE @GroupID INT
	DECLARE @LoweredName NVARCHAR(255)

	IF (@UserID IS NULL)
	BEGIN
		
		/* Get the id for the user name */
		SET @LoweredName=LOWER(@UserName)
		SELECT 
			@UserID=pkID 
		FROM
			tblWindowsUser
		WHERE
			LoweredUserName=@LoweredName
			
		/* User does not exist, nothing to do */
		IF (@UserID IS NULL)
		BEGIN
		    RETURN
		END
	END

	/* We have a valid UserID, now get the group id */
	SET @LoweredName=LOWER(@GroupName)
	SET @GroupID=NULL
	SELECT
		@GroupID = pkID
	FROM
		tblWindowsGroup
	WHERE
		LoweredGroupName=@LoweredName

	/* Group does not exist, nothing to do */
	IF (@GroupID IS NULL)
	BEGIN
        RETURN
    END

	/* We now have a valid role id and user id, remove from relations table */
	DELETE FROM 
	    tblWindowsRelations
	WHERE
		fkWindowsUser=@UserID AND
		fkWindowsGroup=@GroupID
END
GO
PRINT N'Creating [dbo].[netURLSegmentSet]...';


GO
CREATE PROCEDURE [dbo].[netURLSegmentSet]
(
	@URLSegment			NCHAR(255),
	@PageID				INT,
	@LanguageBranch		NCHAR(17) = NULL
)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @LangBranchID NCHAR(17);
	SELECT @LangBranchID=pkID FROM tblLanguageBranch WHERE LanguageID=@LanguageBranch
	IF @LangBranchID IS NULL 
	BEGIN 
		if @LanguageBranch IS NOT NULL
			RAISERROR('Language branch %s is not defined',16,1, @LanguageBranch)
		else
			SET @LangBranchID = -1
	END

	UPDATE tblPageLanguage
	SET URLSegment = RTRIM(@URLSegment)
	WHERE fkPageID = @PageID
	AND (@LangBranchID=-1 OR fkLanguageBranchID=@LangBranchID)
	
	UPDATE tblWorkPage
	SET URLSegment = RTRIM(@URLSegment)
	WHERE fkPageID = @PageID
	AND (@LangBranchID=-1 OR fkLanguageBranchID=@LangBranchID)
END
GO
PRINT N'Creating [dbo].[netURLSegmentListPages]...';


GO
CREATE PROCEDURE [dbo].[netURLSegmentListPages]
(
	@URLSegment	NCHAR(255)
)
AS
BEGIN
	SET NOCOUNT ON

	IF (LEN(@URLSegment) = 0)
	BEGIN
		set @URLSegment = NULL
	END 

	SELECT DISTINCT fkPageID as "PageID"
	FROM tblPageLanguage
	WHERE URLSegment = @URLSegment
	OR (@URLSegment = NULL AND URLSegment = '' OR URLSegment IS NULL)
	
END
GO
PRINT N'Creating [dbo].[netUnmappedPropertyList]...';


GO
CREATE PROCEDURE [dbo].netUnmappedPropertyList
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT 
		tblProperty.LinkGuid as GuidID,
		tblProperty.fkPageID as PageID, 
		tblProperty.fkLanguageBranchID as LanguageBranchID,
		tblPageDefinition.Name as PropertyName,
		tblPageDefinition.fkPageTypeID as PageTypeID
		
	FROM
		tblProperty INNER JOIN tblPageDefinition on tblProperty.fkPageDefinitionID = tblPageDefinition.pkID
	WHERE
		tblProperty.LinkGuid IS NOT NULL AND
		tblProperty.PageLink IS NULL		
END
GO
PRINT N'Creating [dbo].[netUniqueSequenceNext]...';


GO
CREATE PROCEDURE [dbo].[netUniqueSequenceNext]
(
    @Name NVARCHAR (100),
    @Steps INT,
    @NextValue INT OUTPUT
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT OFF

	DECLARE @ErrorVal INT
	
	/* Assume that row exists and try to do an update to get the next value */
	UPDATE tblUniqueSequence SET @NextValue = LastValue = LastValue + @Steps WHERE Name = @Name
	
	/* If no rows were updated, the row did not exist */
	IF @@ROWCOUNT=0
	BEGIN
	
		/* Try to insert row. The reason for not starting with insert is that this operation is only
		needed ONCE for a sequence, the first update will succeed after this initial insert. */
		INSERT INTO tblUniqueSequence (Name, LastValue) VALUES (@Name, @Steps)
		SET @ErrorVal=@@ERROR	
		
		/* An extra safety precaution - parallell execution caused another instance of this proc to
		insert the relevant row between our first update and our insert. This causes a unique constraint
		violation. Note that SET XACT_ABORT OFF prevents error from propagating to calling code. */
		IF @ErrorVal <> 0
		BEGIN
		
			IF @ErrorVal = 2627
			BEGIN
				/* Unique constraint violation - do the update again since the row now exists */
				UPDATE tblUniqueSequence SET @NextValue = LastValue = LastValue + @Steps WHERE Name = @Name
			END
			ELSE
			BEGIN
				/* Some other error than unique key violation, very unlikely but raise an error to make 
				sure it gets noticed. */
				RAISERROR(50001, 14, 1)
			END

		END
		ELSE
		BEGIN
			/* No error from insert, the "next value" will be equal to the requested number of steps. */
			SET @NextValue = @Steps
		END
	END
END
GO
PRINT N'Creating [dbo].[netUnifiedPathSearch]...';


GO
CREATE PROCEDURE dbo.netUnifiedPathSearch
(
    @Path 		NVARCHAR(4000),
    @Param1 	NVARCHAR(255),
    @Value1 	NVARCHAR(255),
    @Param2 	NVARCHAR(255) = NULL,
    @Value2 	NVARCHAR(255) = NULL,
    @Param3 	NVARCHAR(255) = NULL,
    @Value3 	NVARCHAR(255) = NULL
)
AS
BEGIN

    SELECT DISTINCT 
        tblUnifiedPath.Path
    FROM 
        tblUnifiedPath
    WHERE 
        tblUnifiedPath.Path LIKE (@Path + '%') AND 
        (@Param1 IS NULL OR EXISTS(SELECT * FROM tblUnifiedPathProperty WHERE tblUnifiedPathProperty.fkUnifiedPathID=tblUnifiedPath.pkID AND (@Param1='*' OR tblUnifiedPathProperty.KeyName=@Param1) AND tblUnifiedPathProperty.StringValue LIKE( '%' + @Value1 + '%'))) AND
        (@Param2 IS NULL OR EXISTS(SELECT * FROM tblUnifiedPathProperty WHERE tblUnifiedPathProperty.fkUnifiedPathID=tblUnifiedPath.pkID AND (@Param2='*' OR tblUnifiedPathProperty.KeyName=@Param2) AND tblUnifiedPathProperty.StringValue LIKE ('%' + @Value2 + '%'))) AND 
        (@Param3 IS NULL OR EXISTS(SELECT * FROM tblUnifiedPathProperty WHERE tblUnifiedPathProperty.fkUnifiedPathID=tblUnifiedPath.pkID AND (@Param3='*' OR tblUnifiedPathProperty.KeyName=@Param3) AND tblUnifiedPathProperty.StringValue LIKE ('%' + @Value3 + '%')))

END
GO
PRINT N'Creating [dbo].[netUnifiedPathSavePropEntry]...';


GO
CREATE PROCEDURE dbo.netUnifiedPathSavePropEntry
( 
    @id int, 
    @key nvarchar(255), 
    @value nvarchar(2000) 
)
AS
BEGIN
	IF EXISTS(SELECT pkID FROM tblUnifiedPathProperty 
		WHERE fkUnifiedPathID = @id 
		AND LOWER(KeyName) = LOWER(@key))
		BEGIN
			UPDATE tblUnifiedPathProperty
			SET StringValue = @value
			WHERE fkUnifiedPathID = @id
			AND LOWER(KeyName) = LOWER(@key)  
		END
	ELSE
		BEGIN
			INSERT INTO tblUnifiedPathProperty(fkUnifiedPathID, KeyName, StringValue)
			VALUES( @id, @key, @value ) 
		END
END
GO
PRINT N'Creating [dbo].[netUnifiedPathSaveAclEntry]...';


GO
CREATE PROCEDURE dbo.netUnifiedPathSaveAclEntry
( 
    @id int, 
    @name nvarchar(255), 
    @isRole int, 
    @accessMask int
)
AS
BEGIN
	IF EXISTS(SELECT pkID FROM tblUnifiedPathAcl 
		WHERE fkUnifiedPathID = @id 
		AND LOWER([Name]) = LOWER(@name) 
		AND IsRole = @isRole)
		BEGIN
			UPDATE tblUnifiedPathAcl
			SET AccessMask = @accessMask
			WHERE IsRole = @isRole
			AND fkUnifiedPathID = @id
			AND LOWER([Name]) = LOWER(@name)  
		END
	ELSE
		BEGIN
			INSERT INTO tblUnifiedPathAcl(fkUnifiedPathID, [Name], IsRole, AccessMask)
			VALUES( @id, @name, @isRole, @accessMask ) 
		END
END
GO
PRINT N'Creating [dbo].[netUnifiedPathSave]...';


GO
CREATE PROCEDURE dbo.netUnifiedPathSave
(
    @id int output, 
    @virtualPath nvarchar(4000), 
    @inheritAcl int
)
AS
BEGIN
	IF ((SELECT Count(*) FROM tblUnifiedPath WHERE pkID = @id) > 0)
	BEGIN
		UPDATE tblUnifiedPath
		SET InheritAcl = @inheritAcl
		WHERE pkID = @id
	END
	ELSE
	BEGIN
		IF ((SELECT Count(*) FROM tblUnifiedPath WHERE [Path]=@virtualPath) > 0)
		BEGIN 
			RAISERROR('A UnifiedPath %s already exist',16,1, @virtualPath)
		END
		INSERT INTO tblUnifiedPath([Path], InheritAcl)
		VALUES(@virtualPath, @inheritAcl)	
		SET @id =  SCOPE_IDENTITY() 
	END
END
GO
PRINT N'Creating [dbo].[netUnifiedPathMove]...';


GO
CREATE PROCEDURE dbo.netUnifiedPathMove
(
    @fromVirtualPath nvarchar(4000), 
    @toVirtualPath nvarchar(4000)
)
AS
BEGIN
UPDATE tblUnifiedPath
	SET [Path] = @toVirtualPath + SUBSTRING(Path, LEN(@fromVirtualPath) + 1, LEN([Path]) ) 
	WHERE LOWER([Path]) LIKE  LOWER(LOWER(@fromVirtualPath)) + '%'
END
GO
PRINT N'Creating [dbo].[netUnifiedPathLoad]...';


GO
CREATE PROCEDURE dbo.netUnifiedPathLoad
( 
    @virtualPath nvarchar(4000) 
)
AS
BEGIN
	SELECT up.pkID, up.InheritAcl, up.[Path], upa.[Name], upa.IsRole, upa.AccessMask, upp.KeyName, upp.StringValue
	FROM tblUnifiedPath up
		LEFT OUTER JOIN tblUnifiedPathAcl upa ON upa.fkUnifiedPathID = up.pkID
		LEFT OUTER JOIN tblUnifiedPathProperty upp ON upp.fkUnifiedPathID = up.pkID
	WHERE LOWER(up.[Path]) = LOWER(@virtualPath)	
END
GO
PRINT N'Creating [dbo].[netUnifiedPathDeleteMembership]...';


GO
CREATE PROCEDURE [dbo].[netUnifiedPathDeleteMembership]
(
	@UserName NVARCHAR(255) = NULL,
	@IsRole INT = NULL
)
AS
BEGIN
	IF(@UserName IS NOT NULL AND @IsRole IS NOT NULL)
	BEGIN
		DELETE FROM 
		    tblUnifiedPathAcl 
		WHERE 
		    Name=@UserName AND
		    IsRole=@IsRole
	END
END
GO
PRINT N'Creating [dbo].[netUnifiedPathDeleteAll]...';


GO
CREATE PROCEDURE dbo.netUnifiedPathDeleteAll
AS
BEGIN
	DELETE FROM tblUnifiedPathAcl
	WHERE fkUnifiedPathID IN (SELECT pkID FROM tblUnifiedPath)

	DELETE FROM tblUnifiedPathProperty
	WHERE fkUnifiedPathID IN (SELECT pkID FROM tblUnifiedPath)

	DELETE FROM tblUnifiedPath
END
GO
PRINT N'Creating [dbo].[netUnifiedPathDeleteAclAndMeta]...';


GO
CREATE PROCEDURE dbo.netUnifiedPathDeleteAclAndMeta
( 
    @id int 
)
AS
BEGIN
	DELETE FROM tblUnifiedPathAcl
	WHERE fkUnifiedPathID = @id

	DELETE FROM tblUnifiedPathProperty
	WHERE fkUnifiedPathID = @id
	
	
	DELETE FROM tblUnifiedPath
	WHERE pkID = @id
END
GO
PRINT N'Creating [dbo].[netUnifiedPathDelete]...';


GO
CREATE PROCEDURE dbo.netUnifiedPathDelete
(
	@UnifiedPathID INT,
	@UserName NVARCHAR(255) = NULL,
	@IsRole INT = NULL
)
AS
BEGIN
	IF (@UserName IS NULL)
    BEGIN
		DELETE FROM 
		    tblUnifiedPathAcl 
		WHERE 
		    fkUnifiedPathID=@UnifiedPathID
		DELETE FROM 
		    tblUnifiedPathProperty 
		WHERE 
		    fkUnifiedPathID=@UnifiedPathID
		DELETE FROM 
		    tblUnifiedPath 
		WHERE 
		    pkID=@UnifiedPathID
	END 
	ELSE
	BEGIN
		DELETE FROM 
		    tblUnifiedPathAcl 
		WHERE 
		    fkUnifiedPathID=@UnifiedPathID AND 
		    Name=@UserName AND
		    IsRole=@IsRole
	END
END
GO
PRINT N'Creating [dbo].[netTaskWorkflowList]...';


GO
CREATE PROCEDURE dbo.netTaskWorkflowList
(
	@WorkflowInstanceId NVARCHAR(36)
)
AS
BEGIN
	SET NOCOUNT ON

	SELECT
	    pkID AS TaskID,
	    COALESCE(Subject, N'-') AS Subject,
	    [Description],
	    DueDate,
	    Status,
	    Activity,
	    Created,
	    Changed,
	    OwnerName,
	    AssignedToName,
	    AssignedIsRole,
	    State,
	    fkPlugInID,
        WorkflowInstanceId,
	    EventActivityName
	FROM 
	    tblTask
	WHERE
		WorkflowInstanceId=@WorkflowInstanceId
	ORDER BY 
	    Status ASC,
	    DueDate DESC, 
	    Changed DESC
END
GO
PRINT N'Creating [dbo].[netTaskSaveActivity]...';


GO
CREATE PROCEDURE dbo.netTaskSaveActivity
(
    @TaskID INT,
    @Activity NVARCHAR(MAX) = NULL
)
AS
BEGIN
	UPDATE 
	    tblTask 
	SET
		Activity = @Activity
	WHERE 
	    pkID = @TaskID
END
GO
PRINT N'Creating [dbo].[netTaskSave]...';


GO
CREATE PROCEDURE dbo.netTaskSave
(
    @TaskID INT OUTPUT,
    @Subject NVARCHAR(255),
    @Description NVARCHAR(2000) = NULL,
    @DueDate DATETIME = NULL,
    @OwnerName NVARCHAR(255),
    @AssignedToName NVARCHAR(255),
    @AssignedIsRole BIT,
    @Status INT,
    @PlugInID INT = NULL,
    @Activity NVARCHAR(MAX) = NULL,
    @State NVARCHAR(MAX) = NULL,
    @WorkflowInstanceId NVARCHAR(36) = NULL,
    @EventActivityName NVARCHAR(255) = NULL
)
AS
BEGIN
    -- Create new task
	IF @TaskID = 0
	BEGIN
		INSERT INTO tblTask
		    (Subject,
		    Description,
		    DueDate,
		    OwnerName,
		    AssignedToName,
		    AssignedIsRole,
		    Status,
		    Activity,
		    fkPlugInID,
		    State,
		    WorkflowInstanceId,
		    EventActivityName) 
		VALUES
		    (@Subject,
		    @Description,
		    @DueDate,
		    @OwnerName,
		    @AssignedToName,
		    @AssignedIsRole,
		    @Status,
		    @Activity,
		    @PlugInID,
		    @State,
		    @WorkflowInstanceId,
	            @EventActivityName)
		SET @TaskID= SCOPE_IDENTITY() 
		
		RETURN
	END

    -- Update existing task
	UPDATE tblTask SET
		Subject = @Subject,
		Description = @Description,
		DueDate = @DueDate,
		OwnerName = @OwnerName,
		AssignedToName = @AssignedToName,
		AssignedIsRole = @AssignedIsRole,
		Status = @Status,
		Activity = CASE WHEN @Activity IS NULL THEN Activity ELSE @Activity END,
		State = @State,
		fkPlugInID = @PlugInID,
		WorkflowInstanceId = @WorkflowInstanceId,
		EventActivityName = @EventActivityName
	WHERE pkID = @TaskID
END
GO
PRINT N'Creating [dbo].[netTaskLoad]...';


GO
CREATE PROCEDURE dbo.netTaskLoad
(
	@TaskID INT
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT
	    pkID AS TaskID,
	    COALESCE(Subject, N'-') AS Subject,
	    [Description],
	    DueDate,
	    Status,
	    Activity,
	    Created,
	    Changed,
	    OwnerName,
	    AssignedToName,
	    AssignedIsRole,
	    State,
	    fkPlugInID,
 	    WorkflowInstanceId,
	    EventActivityName
	FROM 
	    tblTask
	WHERE 
	    pkID=@TaskID
END
GO
PRINT N'Creating [dbo].[netTaskList]...';


GO
CREATE PROCEDURE dbo.netTaskList
(
	@UserName NVARCHAR(255) = NULL
)
AS
BEGIN
	SET NOCOUNT ON

	SELECT
	    pkID AS TaskID,
	    COALESCE(Subject, N'-') AS Subject,
	    [Description],
	    DueDate,
	    Status,
	    Activity,
	    Created,
	    Changed,
	    OwnerName,
	    AssignedToName,
	    AssignedIsRole,
	    State,
	    fkPlugInID,
            WorkflowInstanceId,
	    EventActivityName
	FROM 
	    tblTask
	WHERE
	    OwnerName=@UserName OR
	    AssignedToName=@UserName OR
	    AssignedIsRole=1 OR
	    @UserName IS NULL
	ORDER BY 
	    Status ASC,
	    DueDate DESC, 
	    Changed DESC
END
GO
PRINT N'Creating [dbo].[netTaskDelete]...';


GO
CREATE PROCEDURE dbo.netTaskDelete
(
	@TaskID INT
)
AS
BEGIN
	SET NOCOUNT ON
	DELETE FROM 
	    tblTask 
	WHERE 
	    pkID=@TaskID
	    
	RETURN @@ROWCOUNT   
END
GO
PRINT N'Creating [dbo].[netTabListDependencies]...';


GO
CREATE PROCEDURE [dbo].netTabListDependencies
(
	@TabID INT
)
AS
BEGIN
	SELECT tblPageDefinitionGroup.pkID as TabID,
		tblPageDefinition.Name as PropertyName,
		tblPageDefinitionGroup.Name as TabName
	FROM tblPageDefinition 
	INNER JOIN tblPageDefinitionGroup
	ON tblPageDefinitionGroup.pkID = tblPageDefinition.Advanced
	WHERE Advanced = @TabID
END
GO
PRINT N'Creating [dbo].[netTabInfoUpdate]...';


GO
CREATE PROCEDURE dbo.netTabInfoUpdate
(
	@pkID int,
	@Name nvarchar(100),
	@DisplayName nvarchar(100),
	@GroupOrder int,
	@Access int
)
AS
BEGIN
	UPDATE tblPageDefinitionGroup	SET 
		Name = @Name,
		DisplayName = @DisplayName,
		GroupOrder = @GroupOrder,
		Access = @Access
	WHERE pkID = @pkID
END
GO
PRINT N'Creating [dbo].[netTabInfoList]...';


GO
CREATE PROCEDURE dbo.netTabInfoList AS
BEGIN
	SELECT 	pkID as TabID, 
			Name,
			DisplayName,
			GroupOrder,
			Access AS AccessMask,
			CONVERT(INT,SystemGroup) AS SystemGroup
	FROM tblPageDefinitionGroup 
	ORDER BY GroupOrder
END
GO
PRINT N'Creating [dbo].[netTabInfoInsert]...';


GO
CREATE PROCEDURE dbo.netTabInfoInsert
(
	@pkID INT OUTPUT,
	@Name NVARCHAR(100),
	@DisplayName NVARCHAR(100),
	@GroupOrder INT,
	@Access INT
)
AS
BEGIN
	INSERT INTO tblPageDefinitionGroup (Name, DisplayName, GroupOrder, Access)
	VALUES (@Name, @DisplayName, @GroupOrder, @Access)
	SET @pkID =  SCOPE_IDENTITY() 
END
GO
PRINT N'Creating [dbo].[netTabInfoDelete]...';


GO
CREATE PROCEDURE dbo.netTabInfoDelete
(
	@pkID		INT,
	@ReplaceID	INT = NULL
)
AS
BEGIN
	IF NOT @ReplaceID IS NULL
		UPDATE tblPageDefinition SET Advanced = @ReplaceID WHERE Advanced = @pkID
	DELETE FROM tblPageDefinitionGroup WHERE pkID = @pkID AND SystemGroup = 0
END
GO
PRINT N'Creating [dbo].[netSubscriptionListRoots]...';


GO
CREATE PROCEDURE dbo.netSubscriptionListRoots
AS
BEGIN

	SELECT tblPage.pkID AS PageID
	FROM tblPage
	INNER JOIN tblProperty ON tblProperty.fkPageID		= tblPage.pkID
	INNER JOIN tblPageDefinition ON tblPageDefinition.pkID	= tblProperty.fkPageDefinitionID
	WHERE tblPageDefinition.Name='EPSUBSCRIBE-ROOT' AND NOT tblProperty.PageLink IS NULL AND tblPage.Deleted=0

END
GO
PRINT N'Creating [dbo].[netSoftLinksUpdateStatus]...';


GO
CREATE PROCEDURE dbo.netSoftLinksUpdateStatus
(
	@pkID int,
	@LastCheckedDate datetime,
	@FirstDateBroken datetime,
	@HttpStatusCode int,
	@LinkStatus int
)
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tblContentSoftlink SET
		LastCheckedDate = @LastCheckedDate,
		FirstDateBroken = @FirstDateBroken,
		HttpStatusCode = @HttpStatusCode,
		LinkStatus = @LinkStatus
	WHERE pkID = @pkID
END
GO
PRINT N'Creating [dbo].[netSoftLinksGetUnchecked]...';


GO
CREATE PROCEDURE dbo.netSoftLinksGetUnchecked
(
	@LastCheckedDate	datetime,
	@LastCheckedDateBroken	datetime,
	@MaxNumberOfLinks INT = 1000
)
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT TOP(@MaxNumberOfLinks) *
	FROM tblContentSoftlink
	WHERE (LinkProtocol like 'http%' OR LinkProtocol is NULL) AND 
		(LastCheckedDate < @LastCheckedDate OR (LastCheckedDate < @LastCheckedDateBroken AND LinkStatus <> 0) OR LastCheckedDate IS NULL)
	ORDER BY LastCheckedDate
END
GO
PRINT N'Creating [dbo].[netSoftLinksGetBrokenCount]...';


GO
CREATE PROCEDURE netSoftLinksGetBrokenCount
	@OwnerContentID int
AS
BEGIN
		SELECT Count(*)
		FROM [tblContentSoftlink]
		INNER JOIN tblTree ON tblContentSoftlink.fkOwnerContentID = tblTree.fkChildID
		WHERE (tblTree.fkParentID = @OwnerContentID OR (tblContentSoftlink.fkOwnerContentID = @OwnerContentID AND tblTree.NestingLevel = 1)) AND LinkStatus <> 0
END
GO
PRINT N'Creating [dbo].[netSoftLinksGetBroken]...';


GO
CREATE PROCEDURE netSoftLinksGetBroken
	@SkipCount int,
	@MaxResults int,
	@RootPageId int
AS
BEGIN
	SELECT [pkID]
		,[fkOwnerContentID]
		,[fkReferencedContentGUID]
		,[OwnerLanguageID]
		,[ReferencedLanguageID]
		,[LinkURL]
		,[LinkType]
		,[LinkProtocol]
		,[ContentLink]
		,[LastCheckedDate]
		,[FirstDateBroken]
		,[HttpStatusCode]
		,[LinkStatus]
	FROM (
		SELECT [pkID]
			,[fkOwnerContentID]
			,[fkReferencedContentGUID]
			,[OwnerLanguageID]
			,[ReferencedLanguageID]
			,[LinkURL]
			,[LinkType]
			,[LinkProtocol]
			,[ContentLink]
			,[LastCheckedDate]
			,[FirstDateBroken]
			,[HttpStatusCode]
			,[LinkStatus]
			,ROW_NUMBER() OVER (ORDER BY pkID ASC) as RowNumber
		FROM [tblContentSoftlink]
		INNER JOIN tblTree ON tblContentSoftlink.fkOwnerContentID = tblTree.fkChildID 
		WHERE (tblTree.fkParentID = @RootPageId OR (tblContentSoftlink.fkOwnerContentID = @RootPageId AND tblTree.NestingLevel = 1)) AND LinkStatus <> 0
		) BrokenLinks
	WHERE BrokenLinks.RowNumber > @SkipCount AND BrokenLinks.RowNumber <= @SkipCount+@MaxResults
END
GO
PRINT N'Creating [dbo].[netSoftLinkByUrl]...';


GO
CREATE PROCEDURE dbo.netSoftLinkByUrl
(
	@LinkURL NVARCHAR(255),
	@ExactMatch INT = 1
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT 
		pkID,
		fkOwnerContentID AS OwnerContentID,
		fkReferencedContentGUID AS ReferencedContentGUID,
		OwnerLanguageID,
		ReferencedLanguageID,
		LinkURL,
		LinkType,
		LinkProtocol,
		LastCheckedDate,
		FirstDateBroken,
		HttpStatusCode,
		LinkStatus
	FROM tblContentSoftlink 
	WHERE (@ExactMatch=1 AND LinkURL LIKE @LinkURL) OR (@ExactMatch=0 AND LinkURL LIKE (@LinkURL + '%'))
END
GO
PRINT N'Creating [dbo].[netSoftLinkList]...';


GO
CREATE PROCEDURE dbo.netSoftLinkList
(
	@ReferenceGUID	uniqueidentifier,
	@Reversed INT = 0
)
AS
BEGIN
	SET NOCOUNT ON
	
	IF @Reversed = 1
		SELECT 
			pkID,
			fkOwnerContentID AS OwnerContentID,
			fkReferencedContentGUID AS ReferencedContentGUID,
			OwnerLanguageID,
			ReferencedLanguageID,
			LinkURL,
			LinkType,
			LinkProtocol,
			LastCheckedDate,
			FirstDateBroken,
			HttpStatusCode,
			LinkStatus
		FROM tblContentSoftlink 
		WHERE fkReferencedContentGUID=@ReferenceGUID
	ELSE
		SELECT 
			SoftLink.pkID,
			Content.pkID AS OwnerContentID,
			SoftLink.fkReferencedContentGUID AS ReferencedContentGUID,
			SoftLink.OwnerLanguageID,
			SoftLink.ReferencedLanguageID,
			SoftLink.LinkURL,
			SoftLink.LinkType,
			SoftLink.LinkProtocol,
			SoftLink.LastCheckedDate,
			SoftLink.FirstDateBroken,
			SoftLink.HttpStatusCode,
			SoftLink.LinkStatus
		FROM tblContentSoftlink AS SoftLink
		INNER JOIN tblContent as Content ON SoftLink.fkOwnerContentID = Content.pkID
		WHERE Content.ContentGUID=@ReferenceGUID
END
GO
PRINT N'Creating [dbo].[netSoftLinkInsert]...';


GO
CREATE PROCEDURE dbo.netSoftLinkInsert
(
	@OwnerContentID	INT,
	@ReferencedContentGUID uniqueidentifier,
	@LinkURL	NVARCHAR(255),
	@LinkType	INT,
	@LinkProtocol	NVARCHAR(10),
	@ContentLink	NVARCHAR(255),
	@LastCheckedDate datetime,
	@FirstDateBroken datetime,
	@HttpStatusCode int,
	@LinkStatus int,
	@OwnerLanguageID int,
	@ReferencedLanguageID int
)
AS
BEGIN
	INSERT INTO tblContentSoftlink
		(fkOwnerContentID,
		fkReferencedContentGUID,
	    OwnerLanguageID,
		ReferencedLanguageID,
		LinkURL,
		LinkType,
		LinkProtocol,
		ContentLink,
		LastCheckedDate,
		FirstDateBroken,
		HttpStatusCode,
		LinkStatus)
	VALUES
		(@OwnerContentID,
		@ReferencedContentGUID,
		@OwnerLanguageID,
		@ReferencedLanguageID,
		@LinkURL,
		@LinkType,
		@LinkProtocol,
		@ContentLink,
		@LastCheckedDate,
		@FirstDateBroken,
		@HttpStatusCode,
		@LinkStatus)
END
GO
PRINT N'Creating [dbo].[netSoftLinkDelete]...';


GO
CREATE PROCEDURE dbo.netSoftLinkDelete
(
	@OwnerContentID	INT,
	@LanguageBranch nchar(17) = NULL
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @LangBranchID INT

	IF NOT @LanguageBranch IS NULL
	BEGIN
		SELECT @LangBranchID = pkID FROM tblLanguageBranch WHERE LanguageID=@LanguageBranch
		IF @LangBranchID IS NULL
		BEGIN
			RAISERROR (N'netSoftLinkDelete: LanguageBranchID is null, possibly empty table tblLanguageBranch', 16, 1)
			RETURN 0
		END
	END

	DELETE FROM tblContentSoftlink WHERE fkOwnerContentID = @OwnerContentID AND (@LanguageBranch IS NULL OR OwnerLanguageID=@LangBranchID)
END
GO
PRINT N'Creating [dbo].[netSoftLinkByPageLink]...';


GO
Create PROCEDURE [dbo].[netSoftLinkByPageLink]
(
	@PageLink NVARCHAR(255)
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT 
		pkID,
		fkOwnerContentID AS OwnerID,
		fkReferencedContentGUID AS ReferencedGUID,
		NULL AS OwnerName,
		NULL AS ReferencedName,
		OwnerLanguageID,
		ReferencedLanguageID,
		LinkURL,
		LinkType as ReferenceType ,
		LinkProtocol,
		LastCheckedDate,
		FirstDateBroken,
		HttpStatusCode,
		LinkStatus
	FROM tblContentSoftlink 
	WHERE [ContentLink] = @PageLink
END
GO
PRINT N'Creating [dbo].[netSoftLinkByExternalLink]...';


GO
Create PROCEDURE [dbo].[netSoftLinkByExternalLink]
(
	@ContentLink NVARCHAR(255),
	@ContentGuid uniqueidentifier = NULL
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT 
		pkID,
		fkOwnerContentID AS OwnerID,
		fkReferencedContentGUID AS ReferencedGUID,
		NULL AS OwnerName,
		NULL AS ReferencedName,
		OwnerLanguageID,
		ReferencedLanguageID,
		LinkURL,
		LinkType as ReferenceType ,
		LinkProtocol,
		LastCheckedDate,
		FirstDateBroken,
		HttpStatusCode,
		LinkStatus
	FROM tblContentSoftlink 
	WHERE [fkReferencedContentGUID] = @ContentGuid OR [ContentLink] = @ContentLink
END
GO
PRINT N'Creating [dbo].[netSiteConfigSet]...';


GO
CREATE PROCEDURE [dbo].[netSiteConfigSet]
	@SiteID VARCHAR(250),
	@PropertyName VARCHAR(250),
	@PropertyValue NVARCHAR(max)
AS
BEGIN
	DECLARE @Id AS INT
	SELECT @Id = pkID FROM tblSiteConfig WHERE SiteID = @SiteID AND PropertyName = @PropertyName

	IF @Id IS NOT NULL
	BEGIN
		-- Update
		UPDATE tblSiteConfig SET PropertyValue = @PropertyValue WHERE pkID = @Id
	END
	ELSE
	BEGIN
		INSERT INTO tblSiteConfig(SiteID, PropertyName, PropertyValue) VALUES(@SiteID, @PropertyName, @PropertyValue)
	END
END
GO
PRINT N'Creating [dbo].[netSiteConfigGet]...';


GO
CREATE PROCEDURE [dbo].[netSiteConfigGet]
	@SiteID VARCHAR(250) = NULL,
	@PropertyName VARCHAR(250)
AS
BEGIN
	IF @SiteID IS NULL
	BEGIN
		SELECT * FROM tblSiteConfig WHERE PropertyName = @PropertyName
	END
	ELSE
	BEGIN
		SELECT * FROM tblSiteConfig WHERE SiteID = @SiteID AND PropertyName = @PropertyName
	END
END
GO
PRINT N'Creating [dbo].[netSiteConfigDelete]...';


GO
CREATE PROCEDURE [dbo].[netSiteConfigDelete]
	@SiteID VARCHAR(250),
	@PropertyName VARCHAR(250)
AS
BEGIN
	DELETE FROM tblSiteConfig WHERE SiteID = @SiteID AND PropertyName = @PropertyName
END
GO
PRINT N'Creating [dbo].[netSchedulerSetRunningState]...';


GO
CREATE PROCEDURE dbo.netSchedulerSetRunningState
	@pkID UNIQUEIDENTIFIER,
	@IsRunning bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    UPDATE tblScheduledItem SET IsRunning = @IsRunning, LastPing = GETDATE(), CurrentStatusMessage = NULL WHERE pkID = @pkID
END
GO
PRINT N'Creating [dbo].[netSchedulerSetCurrentStatus]...';


GO
CREATE PROCEDURE dbo.netSchedulerSetCurrentStatus 
	@pkID UNIQUEIDENTIFIER,
	@StatusMessage nvarchar(2048)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE tblScheduledItem SET CurrentStatusMessage = @StatusMessage
	WHERE pkID = @pkID
END
GO
PRINT N'Creating [dbo].[netSchedulerSave]...';


GO
CREATE PROCEDURE [dbo].netSchedulerSave
(
@pkID		UNIQUEIDENTIFIER,
@Name		NVARCHAR(50),
@Enabled	BIT = 0,
@NextExec 	DATETIME,
@DatePart	NCHAR(2) = NULL,
@Interval	INT = 0,
@MethodName NVARCHAR(100),
@fStatic 	BIT,
@TypeName 	NVARCHAR(1024),
@AssemblyName NVARCHAR(100),
@InstanceData	IMAGE = NULL
)
AS
BEGIN

IF EXISTS(SELECT * FROM tblScheduledItem WHERE pkID=@pkID)
	UPDATE tblScheduledItem SET
		Name 		= @Name,
		Enabled 	= @Enabled,
		NextExec 	= @NextExec,
		[DatePart] 	= @DatePart,
		Interval 		= @Interval,
		MethodName 	= @MethodName,
		fStatic 		= @fStatic,
		TypeName 	= @TypeName,
		AssemblyName 	= @AssemblyName,
		InstanceData	= @InstanceData
	WHERE pkID = @pkID
ELSE
	INSERT INTO tblScheduledItem(pkID,Name,Enabled,NextExec,[DatePart],Interval,MethodName,fStatic,TypeName,AssemblyName,InstanceData)
	VALUES(@pkID,@Name,@Enabled,@NextExec,@DatePart,@Interval, @MethodName,@fStatic,@TypeName,@AssemblyName,@InstanceData)


END
GO
PRINT N'Creating [dbo].[netSchedulerReport]...';


GO
CREATE PROCEDURE [dbo].[netSchedulerReport]
@ScheduledItemId	UNIQUEIDENTIFIER,
@Status INT,
@Text	NVARCHAR(2048) = null,
@utcnow DATETIME,
@MaxHistoryCount	INT = NULL
AS
BEGIN

	UPDATE tblScheduledItem SET LastExec = @utcnow,
								LastStatus = @Status,
								LastText = @Text
	FROM tblScheduledItem
	
	WHERE pkID = @ScheduledItemId

	INSERT INTO tblScheduledItemLog( fkScheduledItemId, [Exec], Status, [Text] ) VALUES(@ScheduledItemId,@utcnow,@Status,@Text)

	WHILE (SELECT COUNT(pkID) FROM tblScheduledItemLog WHERE fkScheduledItemId = @ScheduledItemId) > @MaxHistoryCount
	BEGIN
		DELETE tblScheduledItemLog FROM (SELECT TOP 1 * FROM tblScheduledItemLog WHERE fkScheduledItemId = @ScheduledItemId ORDER BY tblScheduledItemLog.pkID) AS T1
		WHERE tblScheduledItemLog.pkID = T1.pkID
	END	
END
GO
PRINT N'Creating [dbo].[netSchedulerRemove]...';


GO
CREATE procedure dbo.netSchedulerRemove
@ID	uniqueidentifier
as
begin

	set nocount on
	
	delete from tblScheduledItemLog where fkScheduledItemId = @ID
	delete from tblScheduledItem where pkID = @ID
	
	return
end
GO
PRINT N'Creating [dbo].[netSchedulerLoadJob]...';


GO
CREATE PROCEDURE dbo.netSchedulerLoadJob 
	@pkID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
    SELECT CONVERT(NVARCHAR(40),pkID) AS pkID,Name,CONVERT(INT,Enabled) AS Enabled,LastExec,LastStatus,LastText,NextExec,[DatePart],Interval,MethodName,CONVERT(INT,fStatic) AS fStatic,TypeName,AssemblyName,InstanceData, IsRunning, CurrentStatusMessage, DateDiff(second, LastPing, GetDate()) as SecondsAfterLastPing
	FROM tblScheduledItem
	WHERE pkID = @pkID
END
GO
PRINT N'Creating [dbo].[netSchedulerListLog]...';


GO
CREATE PROCEDURE [dbo].netSchedulerListLog
(
	@pkID UNIQUEIDENTIFIER
)
AS
BEGIN

	SELECT TOP 100 [Exec], Status, [Text]
	FROM tblScheduledItemLog
	WHERE fkScheduledItemId=@pkID
	ORDER BY [Exec] DESC
END
GO
PRINT N'Creating [dbo].[netSchedulerList]...';


GO
CREATE PROCEDURE [dbo].netSchedulerList
AS
BEGIN

	SELECT CONVERT(NVARCHAR(40),pkID) AS pkID,Name,CONVERT(INT,Enabled) AS Enabled,LastExec,LastStatus,LastText,NextExec,[DatePart],Interval,MethodName,CONVERT(INT,fStatic) AS fStatic,TypeName,AssemblyName,InstanceData, IsRunning, CurrentStatusMessage, DateDiff(second, LastPing, GetDate()) as SecondsAfterLastPing
	FROM tblScheduledItem
	ORDER BY Name ASC

END
GO
PRINT N'Creating [dbo].[netSchedulerGetNext]...';


GO
CREATE PROCEDURE dbo.netSchedulerGetNext
(
	@ID			UNIQUEIDENTIFIER OUTPUT,	-- returned id of new item to queue 
	@NextExec	DATETIME		 OUTPUT		-- returned nextExec of new item to queue
)
AS
BEGIN

	SET NOCOUNT ON

	SET @ID = NULL
	SET @NextExec = NULL

	SELECT TOP 1 @ID = tblScheduledItem.pkID, @NextExec = tblScheduledItem.NextExec
	FROM tblScheduledItem
	WHERE NextExec IS NOT NULL AND
		Enabled = 1
	ORDER BY NextExec ASC
END
GO
PRINT N'Creating [dbo].[netSchedulerExecute]...';


GO
CREATE PROCEDURE dbo.netSchedulerExecute
(
	@pkID     uniqueidentifier,
	@nextExec datetime,
	@utcnow datetime,
	@pingSeconds int
)
as
begin

	set nocount on
	
	
	/**
	 * is the scheduled nextExec still valid? 
	 * (that is, no one else has already begun executing it?)
	 */
	if exists( select * from tblScheduledItem with (rowlock,updlock) where pkID = @pkID and NextExec = @nextExec and Enabled = 1 and (IsRunning <> 1 OR (GetDate() > DATEADD(second, @pingSeconds, LastPing))) )
	begin
	
		/**
		 * ya, calculate and set nextexec for the item 
		 * (or set to null if not recurring)
		 */
		update tblScheduledItem set NextExec =  case when coalesce(Interval,0) > 0 and [DatePart] is not null then 
		
															case [DatePart] when 'ms' then dateadd( ms, Interval, case when dateadd( ms, Interval, NextExec ) < @utcnow then @utcnow else NextExec end )
																			when 'ss' then dateadd( ss, Interval, case when dateadd( ss, Interval, NextExec ) < @utcnow then @utcnow else NextExec end )
																			when 'mi' then dateadd( mi, Interval, case when dateadd( mi, Interval, NextExec ) < @utcnow then @utcnow else NextExec end )
																			when 'hh' then dateadd( hh, Interval, case when dateadd( hh, Interval, NextExec ) < @utcnow then @utcnow else NextExec end )
																			when 'dd' then dateadd( dd, Interval, case when dateadd( dd, Interval, NextExec ) < @utcnow then @utcnow else NextExec end )
																			when 'wk' then dateadd( wk, Interval, case when dateadd( wk, Interval, NextExec ) < @utcnow then @utcnow else NextExec end )
																			when 'mm' then dateadd( mm, Interval, case when dateadd( mm, Interval, NextExec ) < @utcnow then @utcnow else NextExec end )
																			when 'yy' then dateadd( yy, Interval, case when dateadd( yy, Interval, NextExec ) < @utcnow then @utcnow else NextExec end )
																			
															end
													
													 else null
									            end
		from   tblScheduledItem
		
		where  pkID = @pkID
		
		
		/**
		 * now retrieve all detailed data (type, assembly & instance) 
		 * for the job
		 */
		select	tblScheduledItem.MethodName,
				tblScheduledItem.fStatic,
				tblScheduledItem.TypeName,
				tblScheduledItem.AssemblyName,
				tblScheduledItem.InstanceData
		
		from	tblScheduledItem
		
		where	pkID = @pkID
		
	end
	
end
GO
PRINT N'Creating [dbo].[netSchedulerAdd]...';


GO
CREATE PROCEDURE dbo.netSchedulerAdd
(
	@out_Id			uniqueidentifier output,
	@methodName		nvarchar(100),
	@fStatic		bit,
	@typeName		nvarchar(1024),
	@assemblyName	nvarchar(100),
	@data			image,
	@dtExec			datetime,
	@sRecurDatePart	nchar(2),
	@Interval		int,
	@out_fRefresh	bit output
)
as
begin

	set nocount on
		
	select @out_Id = newid()
	
	select @out_fRefresh = case when exists( select * from tblScheduledItem where NextExec < @dtExec ) then 0 else 1 end
	
	insert into tblScheduledItem( pkID, Enabled, MethodName, fStatic, TypeName, AssemblyName, NextExec, [DatePart], [Interval], InstanceData )
	   values( @out_Id, 1, @methodName, @fStatic, @typeName, @assemblyName, @dtExec, @sRecurDatePart, @Interval, @data )
	
	return
end
GO
PRINT N'Creating [dbo].[netReportSimpleAddresses]...';


GO
-- Return a list of pages in a particular branch of the tree changed between a start date and a stop date
CREATE PROCEDURE [dbo].[netReportSimpleAddresses](
	@PageID int,
	@Language int = -1,
	@PageSize int,
	@PageNumber int = 0,
	@SortColumn varchar(40) = 'ExternalURL',
	@SortDescending bit = 0
)
AS
BEGIN
	SET NOCOUNT ON;

	WITH PageCTE AS
	(
		SELECT ROW_NUMBER() OVER(ORDER BY 
			-- Page Name Sorting
			CASE WHEN @SortColumn = 'PageName' AND @SortDescending = 1 THEN tblPageLanguage.Name END DESC,
			CASE WHEN @SortColumn = 'PageName' THEN tblPageLanguage.Name END ASC,
			-- Changed By Sorting
			CASE WHEN @SortColumn = 'ChangedBy' AND @SortDescending = 1 THEN tblPageLanguage.ChangedByName END DESC,
			CASE WHEN @SortColumn = 'ChangedBy' THEN tblPageLanguage.ChangedByName END ASC,
			-- External Url Sorting
			CASE WHEN @SortColumn = 'ExternalURL' AND @SortDescending = 1 THEN tblPageLanguage.ExternalURL END DESC,
			CASE WHEN @SortColumn = 'ExternalURL' THEN tblPageLanguage.ExternalURL END ASC,
			-- Language Sorting
			CASE WHEN @SortColumn = 'Language' AND @SortDescending = 1 THEN tblLanguageBranch.LanguageID END DESC,
			CASE WHEN @SortColumn = 'Language' THEN tblLanguageBranch.LanguageID END ASC
		) AS rownum,
		tblPageLanguage.fkPageID, tblPageLanguage.[Version], count(*) over () as totcount
		FROM tblPageLanguage 
		INNER JOIN tblTree ON tblTree.fkChildID=tblPageLanguage.fkPageID 
		INNER JOIN tblPage ON tblPage.pkID=tblPageLanguage.fkPageID 
		INNER JOIN tblPageType ON tblPageType.pkID=tblPage.fkPageTypeID
		INNER JOIN tblLanguageBranch ON tblLanguageBranch.pkID=tblPageLanguage.fkLanguageBranchID 
		WHERE 
        (tblTree.fkParentID=@PageID OR (tblPageLanguage.fkPageID=@PageID AND tblTree.NestingLevel = 1 ))
        AND 
        (tblPageLanguage.ExternalURL IS NOT NULL)
        AND tblPage.ContentType = 0
        AND
        (@Language = -1 OR tblPageLanguage.fkLanguageBranchID = @Language)
	)
	SELECT PageCTE.fkPageID, PageCTE.[Version], PageCTE.rownum, totcount
	FROM PageCTE
	WHERE rownum > @PageSize * (@PageNumber)
	AND rownum <= @PageSize * (@PageNumber+1)
	ORDER BY rownum
END
GO
PRINT N'Creating [dbo].[netReportReadyToPublish]...';


GO
-- Return a list of pages in a particular branch of the tree published between a start date and a stop date
CREATE PROCEDURE [dbo].netReportReadyToPublish(
	@PageID int,
	@StartDate datetime,
	@StopDate datetime,
	@Language int = -1,
	@ChangedByUserName nvarchar(256) = null,
	@PageSize int,
	@PageNumber int = 0,
	@SortColumn varchar(40) = 'PageName',
	@SortDescending bit = 0,
	@IsReadyToPublish bit = 1
)
AS
BEGIN
	SET NOCOUNT ON;
	WITH PageCTE AS
                    (
                        SELECT ROW_NUMBER() OVER(ORDER BY 
							-- Page Name Sorting
							CASE WHEN @SortColumn = 'PageName' AND @SortDescending = 1 THEN tblWorkPage.Name END DESC,
							CASE WHEN @SortColumn = 'PageName' THEN tblWorkPage.Name END ASC,
							-- Saved Sorting
							CASE WHEN @SortColumn = 'Saved' AND @SortDescending = 1 THEN tblWorkPage.Saved END DESC,
							CASE WHEN @SortColumn = 'Saved' THEN tblWorkPage.Saved END ASC,
							-- StartPublish Sorting
							CASE WHEN @SortColumn = 'StartPublish' AND @SortDescending = 1 THEN tblWorkPage.StartPublish END DESC,
							CASE WHEN @SortColumn = 'StartPublish' THEN tblWorkPage.StartPublish END ASC,
							-- Changed By Sorting
							CASE WHEN @SortColumn = 'ChangedBy' AND @SortDescending = 1 THEN tblWorkPage.ChangedByName END DESC,
							CASE WHEN @SortColumn = 'ChangedBy' THEN tblWorkPage.ChangedByName END ASC,
							-- Language Sorting
							CASE WHEN @SortColumn = 'Language' AND @SortDescending = 1 THEN tblLanguageBranch.LanguageID END DESC,
							CASE WHEN @SortColumn = 'Language' THEN tblLanguageBranch.LanguageID END ASC
							, 
							tblWorkPage.pkID ASC
                        ) AS rownum,
                        tblWorkPage.fkPageID, count(tblWorkPage.fkPageID) over () as totcount,
                        tblWorkPage.pkID as versionId
                        FROM tblWorkPage 
                        INNER JOIN tblTree ON tblTree.fkChildID=tblWorkPage.fkPageID 
                        INNER JOIN tblPage ON tblPage.pkID=tblWorkPage.fkPageID 
						INNER JOIN tblLanguageBranch ON tblLanguageBranch.pkID=tblWorkPage.fkLanguageBranchID 
                        WHERE 
							(tblTree.fkParentID=@PageID OR (tblWorkPage.fkPageID=@PageID AND tblTree.NestingLevel = 1 ))
                        AND
							(LEN(@ChangedByUserName) = 0 OR tblWorkPage.ChangedByName = @ChangedByUserName)
                        AND
							tblPage.ContentType = 0
                        AND
							(@Language = -1 OR tblWorkPage.fkLanguageBranchID = @Language)
                        AND 
							(@StartDate IS NULL OR tblWorkPage.Saved > @StartDate)
                        AND
							(@StopDate IS NULL OR tblWorkPage.Saved < @StopDate)
                        AND
							(tblWorkPage.ReadyToPublish = @IsReadyToPublish AND tblWorkPage.HasBeenPublished = 0)
                    )
                    SELECT PageCTE.fkPageID, PageCTE.rownum, totcount, PageCTE.versionId
                    FROM PageCTE
                    WHERE rownum > @PageSize * (@PageNumber)
                    AND rownum <= @PageSize * (@PageNumber+1)
                    ORDER BY rownum
	END
GO
PRINT N'Creating [dbo].[netReportPublishedPages]...';


GO
-- Return a list of pages in a particular branch of the tree published between a start date and a stop date
CREATE PROCEDURE [dbo].[netReportPublishedPages](
	@PageID int,
	@StartDate datetime,
	@StopDate datetime,
	@Language int = -1,
	@ChangedByUserName nvarchar(256) = null,
	@PageSize int,
	@PageNumber int = 0,
	@SortColumn varchar(40) = 'StartPublish',
	@SortDescending bit = 0
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @OrderBy NVARCHAR(MAX)
	SET @OrderBy =
		CASE @SortColumn
			WHEN 'PageName' THEN 'tblPageLanguage.Name'
			WHEN 'StartPublish' THEN 'tblPageLanguage.StartPublish'
			WHEN 'StopPublish' THEN 'tblPageLanguage.StopPublish'
			WHEN 'ChangedBy' THEN 'tblPageLanguage.ChangedByName'
			WHEN 'Saved' THEN 'tblPageLanguage.Saved'
			WHEN 'Language' THEN 'tblLanguageBranch.LanguageID'
			WHEN 'PageTypeName' THEN 'tblPageType.Name'
		END
	IF(@SortDescending = 1)
		SET @OrderBy = @OrderBy + ' DESC'

	DECLARE @sql NVARCHAR(MAX)
	SET @sql = 'WITH PageCTE AS
	(
		SELECT ROW_NUMBER() OVER(ORDER BY ' 
			+ @OrderBy
			+ ') AS rownum,
		tblPageLanguage.fkPageID, tblPageLanguage.Version AS PublishedVersion, count(*) over () as totcount
		FROM tblPageLanguage 
		INNER JOIN tblTree ON tblTree.fkChildID=tblPageLanguage.fkPageID 
		INNER JOIN tblPage ON tblPage.pkID=tblPageLanguage.fkPageID 
		INNER JOIN tblPageType ON tblPageType.pkID=tblPage.fkPageTypeID 
		INNER JOIN tblLanguageBranch ON tblLanguageBranch.pkID=tblPageLanguage.fkLanguageBranchID
		WHERE
		(tblTree.fkParentID=@PageID OR (tblPageLanguage.fkPageID=@PageID AND tblTree.NestingLevel = 1 ))
        AND tblPage.ContentType = 0
		AND tblPageLanguage.Status=4
		AND 
		(@StartDate IS NULL OR tblPageLanguage.StartPublish>@StartDate)
		AND
		(@StopDate IS NULL OR tblPageLanguage.StartPublish<@StopDate)
		AND
		(@Language = -1 OR tblPageLanguage.fkLanguageBranchID = @Language)
		AND
		(@ChangedByUserName IS NULL OR tblPageLanguage.ChangedByName = @ChangedByUserName)
	)
	SELECT PageCTE.fkPageID, PageCTE.PublishedVersion, PageCTE.rownum, totcount
	FROM PageCTE
	WHERE rownum > @PageSize * (@PageNumber)
	AND rownum <= @PageSize * (@PageNumber+1)
	ORDER BY rownum'

	EXEC sp_executesql @sql, N'@PageID int, @StartDate datetime, @StopDate datetime, @Language int, @ChangedByUserName nvarchar(256), @PageSize int, @PageNumber int',
		@PageID = @PageID, 
		@StartDate = @StartDate, 
		@StopDate = @StopDate, 
		@Language = @Language, 
		@ChangedByUserName = @ChangedByUserName, 
		@PageSize = @PageSize, 
		@PageNumber = @PageNumber
	
END
GO
PRINT N'Creating [dbo].[netReportExpiredPages]...';


GO
-- Returns a list of pages which will expire between the supplied dates in a particular branch of the tree.
CREATE PROCEDURE [dbo].[netReportExpiredPages](
	@PageID int,
	@StartDate datetime,
	@StopDate datetime,
	@Language int = -1,
	@PageSize int,
	@PageNumber int = 0,
	@SortColumn varchar(40) = 'StopPublish',
	@SortDescending bit = 0,
	@PublishedByName nvarchar(256) = null
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @OrderBy NVARCHAR(MAX)
	SET @OrderBy =
		CASE @SortColumn
			WHEN 'PageName' THEN 'tblPageLanguage.Name'
			WHEN 'StartPublish' THEN 'tblPageLanguage.StartPublish'
			WHEN 'StopPublish' THEN 'tblPageLanguage.StopPublish'
			WHEN 'ChangedBy' THEN 'tblPageLanguage.ChangedByName'
			WHEN 'Saved' THEN 'tblPageLanguage.Saved'
			WHEN 'Language' THEN 'tblLanguageBranch.LanguageID'
			WHEN 'PageTypeName' THEN 'tblPageType.Name'
		END
	IF(@SortDescending = 1)
		SET @OrderBy = @OrderBy + ' DESC'

    DECLARE @sql NVARCHAR(MAX)
	SET @sql = 'WITH PageCTE AS
    (
        SELECT ROW_NUMBER() OVER(ORDER BY ' 
			+ @OrderBy 
			+ ') AS rownum,
        tblPageLanguage.fkPageID, tblPageLanguage.Version AS PublishedVersion, count(tblPageLanguage.fkPageID) over () as totcount                        
        FROM tblPageLanguage 
        INNER JOIN tblTree ON tblTree.fkChildID=tblPageLanguage.fkPageID 
        INNER JOIN tblPage ON tblPage.pkID=tblPageLanguage.fkPageID 
        INNER JOIN tblPageType ON tblPageType.pkID=tblPage.fkPageTypeID 
        INNER JOIN tblLanguageBranch ON tblLanguageBranch.pkID=tblPageLanguage.fkLanguageBranchID 
        WHERE 
        (tblTree.fkParentID = @PageID OR (tblPageLanguage.fkPageID = @PageID AND tblTree.NestingLevel = 1))
        AND 
        (@StartDate IS NULL OR tblPageLanguage.StopPublish>@StartDate)
        AND
        (@StopDate IS NULL OR tblPageLanguage.StopPublish<@StopDate)
		AND
		(@Language = -1 OR tblPageLanguage.fkLanguageBranchID = @Language)
        AND tblPage.ContentType = 0
		AND tblPageLanguage.Status=4
		AND
		(LEN(@PublishedByName) = 0 OR tblPageLanguage.ChangedByName = @PublishedByName)
    )
    SELECT PageCTE.fkPageID, PageCTE.PublishedVersion, PageCTE.rownum, totcount
    FROM PageCTE
    WHERE rownum > @PageSize * (@PageNumber)
    AND rownum <= @PageSize * (@PageNumber+1)
    ORDER BY rownum'
    
    EXEC sp_executesql @sql, N'@PageID int, @StartDate datetime, @StopDate datetime, @Language int, @PublishedByName nvarchar(256), @PageSize int, @PageNumber int',
		@PageID = @PageID, 
		@StartDate = @StartDate, 
		@StopDate = @StopDate, 
		@Language = @Language, 
		@PublishedByName = @PublishedByName, 
		@PageSize = @PageSize, 
		@PageNumber = @PageNumber
END
GO
PRINT N'Creating [dbo].[netReportChangedPages]...';


GO
-- Return a list of pages in a particular branch of the tree changed between a start date and a stop date
CREATE PROCEDURE [dbo].[netReportChangedPages](
	@PageID int,
	@StartDate datetime,
	@StopDate datetime,
	@Language int = -1,
	@ChangedByUserName nvarchar(256) = null,
	@PageSize int,
	@PageNumber int = 0,
	@SortColumn varchar(40) = 'Saved',
	@SortDescending bit = 0
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @OrderBy NVARCHAR(MAX)
	SET @OrderBy =
		CASE @SortColumn
			WHEN 'PageName' THEN 'tblPageLanguage.Name'
			WHEN 'ChangedBy' THEN 'tblPageLanguage.ChangedByName'
			WHEN 'Saved' THEN 'tblPageLanguage.Saved'
			WHEN 'Language' THEN 'tblLanguageBranch.LanguageID'
			WHEN 'PageTypeName' THEN 'tblPageType.Name'
		END
	IF(@SortDescending = 1)
		SET @OrderBy = @OrderBy + ' DESC'
		
	DECLARE @sql NVARCHAR(MAX)
	Set @sql = 'WITH PageCTE AS
	(
		SELECT ROW_NUMBER() OVER(ORDER BY '
			+ @OrderBy
			+ ') AS rownum,
		tblPageLanguage.fkPageID, tblPageLanguage.Version AS PublishedVersion, count(*) over () as totcount
		FROM tblPageLanguage 
		INNER JOIN tblTree ON tblTree.fkChildID=tblPageLanguage.fkPageID 
		INNER JOIN tblPage ON tblPage.pkID=tblPageLanguage.fkPageID 
		INNER JOIN tblPageType ON tblPageType.pkID=tblPage.fkPageTypeID 
		INNER JOIN tblLanguageBranch ON tblLanguageBranch.pkID=tblPageLanguage.fkLanguageBranchID 
		WHERE (tblTree.fkParentID=@PageID OR (tblPageLanguage.fkPageID=@PageID AND tblTree.NestingLevel = 1 ))
        AND (@StartDate IS NULL OR tblPageLanguage.Saved>@StartDate)
        AND (@StopDate IS NULL OR tblPageLanguage.Saved<@StopDate)
        AND (@Language = -1 OR tblPageLanguage.fkLanguageBranchID = @Language)
        AND (@ChangedByUserName IS NULL OR tblPageLanguage.ChangedByName = @ChangedByUserName)
        AND (@ChangedByUserName IS NULL OR tblPageLanguage.ChangedByName = @ChangedByUserName)
        AND tblPage.ContentType = 0
        AND tblPageLanguage.Status=4
	)
	SELECT PageCTE.fkPageID, PageCTE.PublishedVersion, PageCTE.rownum, totcount
	FROM PageCTE
	WHERE rownum > @PageSize * (@PageNumber)
	AND rownum <= @PageSize * (@PageNumber+1)
	ORDER BY rownum'
	
	EXEC sp_executesql @sql, N'@PageID int, @StartDate datetime, @StopDate datetime, @Language int, @ChangedByUserName nvarchar(256), @PageSize int, @PageNumber int',
		@PageID = @PageID, 
		@StartDate = @StartDate, 
		@StopDate = @StopDate, 
		@Language = @Language, 
		@ChangedByUserName = @ChangedByUserName, 
		@PageSize = @PageSize, 
		@PageNumber = @PageNumber
END
GO
PRINT N'Creating [dbo].[netRemoteSiteSave]...';


GO
CREATE PROCEDURE dbo.netRemoteSiteSave
(
	@ID				INT OUTPUT,
	@Name			NVARCHAR(100),
	@Url			NVARCHAR(255),
	@IsTrusted		BIT = 0,
	@UserName		NVARCHAR(50) = NULL,
	@Password		NVARCHAR(50) = NULL,
	@Domain			NVARCHAR(50) = NULL,
	@AllowUrlLookup BIT = 0
)
AS
BEGIN
	IF @ID=0
	BEGIN
		INSERT INTO tblRemoteSite(Name,Url,IsTrusted,UserName,Password,Domain,AllowUrlLookup) VALUES(@Name,@Url,@IsTrusted,@UserName,@Password,@Domain,@AllowUrlLookup)
		SET @ID =  SCOPE_IDENTITY() 
	END
	ELSE
		UPDATE tblRemoteSite SET Name=@Name,Url=@Url,IsTrusted=@IsTrusted,UserName=@UserName,Password=@Password,Domain=@Domain,AllowUrlLookup=@AllowUrlLookup WHERE pkID=@ID
END
GO
PRINT N'Creating [dbo].[netRemoteSiteLoad]...';


GO
CREATE PROCEDURE dbo.netRemoteSiteLoad
(
	@ID INT
)
AS
BEGIN
	SELECT pkID,Name,Url,IsTrusted,UserName,[Password],Domain,AllowUrlLookup
	FROM tblRemoteSite
	WHERE pkID=@ID
END
GO
PRINT N'Creating [dbo].[netRemoteSiteList]...';


GO
CREATE PROCEDURE dbo.netRemoteSiteList
AS
BEGIN
SELECT pkID,Name,Url,IsTrusted,UserName,[Password],Domain,AllowUrlLookup
FROM tblRemoteSite
ORDER BY Name ASC
END
GO
PRINT N'Creating [dbo].[netRemoteSiteDelete]...';


GO
CREATE PROCEDURE dbo.netRemoteSiteDelete
(
	@ID INT OUTPUT
)
AS
BEGIN
	DELETE FROM tblRemoteSite WHERE pkID=@ID
END
GO
PRINT N'Creating [dbo].[netReadyToPublishList]...';


GO
CREATE PROCEDURE [dbo].[netReadyToPublishList]
(
    @Offset INT = 0,
    @Count INT = 50,
    @LanguageBranch NCHAR(17) = NULL
)
AS
BEGIN
	SET NOCOUNT ON

    DECLARE @LangBranchID NCHAR(17);
	SELECT @LangBranchID = pkID FROM tblLanguageBranch WHERE LanguageID = @LanguageBranch
	IF @LangBranchID IS NULL 
	BEGIN 
		if @LanguageBranch IS NOT NULL
			RAISERROR('Language branch %s is not defined',16,1, @LanguageBranch)
		else
			SET @LangBranchID = -1
	END

	DECLARE @InvariantLangBranchID NCHAR(17);
	SELECT @InvariantLangBranchID = pkID FROM tblLanguageBranch WHERE LanguageID = ''

	-- Determine the first record and last record
	DECLARE @FirstRecord int, @LastRecord int

	SELECT @FirstRecord = @Offset
	SELECT @LastRecord = (@Offset + @Count + 1);


	WITH TempResult as
	(
		SELECT	ROW_NUMBER() OVER(ORDER BY W.Saved DESC) as RowNumber,
			W.fkContentID AS ContentID,
			W.pkID AS WorkID,
			3 AS VersionStatus,
			W.ChangedByName AS UserName,
			W.Saved AS ItemCreated,
			W.Name,
			W.fkLanguageBranchID as LanguageBranch,
			W.CommonDraft,
			W.fkMasterVersionID as MasterVersion,
			CASE WHEN C.fkMasterLanguageBranchID=W.fkLanguageBranchID THEN 1 ELSE 0 END AS IsMasterLanguageBranch
		FROM
			tblWorkContent AS W
		INNER JOIN
			tblContent AS C ON C.pkID=W.fkContentID
		WHERE
			W.Status = 3 AND
			C.Deleted=0 AND
			(@LanguageBranch = NULL OR 
			W.fkLanguageBranchID = @LangBranchID OR
			W.fkLanguageBranchID = @InvariantLangBranchID)
	)
	SELECT  TOP (@LastRecord - 1) *
	FROM    TempResult
	WHERE   RowNumber > @FirstRecord AND
		  RowNumber < @LastRecord
   		
END
GO
PRINT N'Creating [dbo].[netQuickSearchListFolderID]...';


GO
CREATE PROCEDURE dbo.netQuickSearchListFolderID
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT ExternalFolderID,pkID AS PageID
	FROM tblPage
	ORDER BY ExternalFolderID ASC
END
GO
PRINT N'Creating [dbo].[netQuickSearchByPath]...';


GO
CREATE PROCEDURE dbo.netQuickSearchByPath
(
	@Path	NVARCHAR(1000),
	@PageID	INT,
	@LanguageBranch	NCHAR(17) = NULL
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Index INT
	DECLARE @LastIndex INT
	DECLARE @LinkURL NVARCHAR(255)
	DECLARE @Name NVARCHAR(255)
	DECLARE @LangBranchID NCHAR(17);
	
	SELECT @LangBranchID=pkID FROM tblLanguageBranch WHERE LanguageID=@LanguageBranch
	IF @LangBranchID IS NULL 
	BEGIN 
		if @LanguageBranch IS NOT NULL
			RAISERROR('Language branch %s is not defined',16,1, @LanguageBranch)
		else
			SET @LangBranchID = -1
	END


	SET @Index = CHARINDEX('/',@Path)
	SET @LastIndex = 0

	WHILE @Index > 0 OR @Index IS NULL
	BEGIN
		SET @Name = SUBSTRING(@Path,@LastIndex,@Index-@LastIndex)

		SELECT TOP 1 @PageID=pkID,@LinkURL=tblPageLanguage.LinkURL
		FROM tblPageLanguage
		LEFT JOIN tblPage AS tblPage ON tblPage.pkID=tblPageLanguage.fkPageID
		WHERE tblPageLanguage.Name LIKE @Name AND (tblPage.fkParentID=@PageID OR @PageID IS NULL)
		AND (tblPageLanguage.fkLanguageBranchID=@LangBranchID OR @LangBranchID=-1)

		IF @@ROWCOUNT=0
		BEGIN
			SET @Index=0
			SET @LinkURL = NULL
		END
		ELSE
		BEGIN
			SET @LastIndex = @Index + 1
			SET @Index = CHARINDEX('/',@Path,@LastIndex+1)
		END
	END	
		
	SELECT @LinkURL
END
GO
PRINT N'Creating [dbo].[netQuickSearchByFolderID]...';


GO
CREATE PROCEDURE dbo.netQuickSearchByFolderID
(
	@FolderID	INT
)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT TOP 1 pkID
	FROM tblPage
	WHERE ExternalFolderID=@FolderID
END
GO
PRINT N'Creating [dbo].[netQuickSearchByExternalUrl]...';


GO
CREATE PROCEDURE dbo.netQuickSearchByExternalUrl
(
	@Url	NVARCHAR(255)
)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @LoweredUrl NVARCHAR(255)
	
	SET @LoweredUrl = Lower(@Url)

	/*
		Performance notes: The subquery "Pages" must not have any more predicates or return the values used in the outer WHERE-clause, otherwise
		SQL Server falls back to a costly index scan. The performance hints LOOP on the joins are also required for the same reason, the resultset
		from "Pages" is so small that a loop join is superior in performance to index scan/hash match, a factor 1000x.
	*/
	
	SELECT 
		tblPageLanguage.fkPageID,
		tblLanguageBranch.LanguageID as LanguageBranch
	FROM 
		(
			SELECT fkPageID,fkLanguageBranchID
			FROM tblPageLanguage
			WHERE tblPageLanguage.ExternalURL=@LoweredUrl
		) AS Pages
	INNER LOOP JOIN 
		tblPage ON tblPage.pkID = Pages.fkPageID
	INNER LOOP JOIN
		tblPageLanguage ON tblPageLanguage.fkPageID=Pages.fkPageID AND tblPageLanguage.fkLanguageBranchID=Pages.fkLanguageBranchID
	INNER LOOP JOIN
		tblLanguageBranch ON tblLanguageBranch.pkID = Pages.fkLanguageBranchID
	WHERE 
		tblPage.Deleted=0 AND 
		tblPageLanguage.[Status]=4 AND
		tblPageLanguage.StartPublish <= GetDate() AND
		(tblPageLanguage.StopPublish IS NULL OR tblPageLanguage.StopPublish >= GetDate())
	ORDER BY
		tblPageLanguage.Changed DESC
END
GO
PRINT N'Creating [dbo].[netPropertySearchNull]...';


GO
CREATE PROCEDURE dbo.netPropertySearchNull
(
	@PageID			INT,
	@PropertyName 	NVARCHAR(255),
	@LanguageBranch	NCHAR(17) = NULL
)
AS
BEGIN
	DECLARE @LangBranchID NCHAR(17);

	SELECT @LangBranchID=pkID FROM tblLanguageBranch WHERE LanguageID=@LanguageBranch
	IF @LangBranchID IS NULL 
	BEGIN 
		if @LanguageBranch IS NOT NULL
			RAISERROR('Language branch %s is not defined',16,1, @LanguageBranch)
		else
			SET @LangBranchID = -1
	END

	
	SELECT DISTINCT(tblPageLanguage.fkPageID)
	FROM tblPageLanguage
	INNER JOIN tblTree ON tblTree.fkChildID=tblPageLanguage.fkPageID
	INNER JOIN tblPage ON tblPage.pkID=tblPageLanguage.fkPageID
	INNER JOIN tblPageType ON tblPageType.pkID=tblPage.fkPageTypeID
	INNER JOIN tblPageDefinition ON tblPageDefinition.fkPageTypeID=tblPageType.pkID
	WHERE tblPageType.ContentType = 0
	AND tblTree.fkParentID=@PageID  
	AND tblPageDefinition.Name=@PropertyName
	AND (@LangBranchID=-1 OR tblPageLanguage.fkLanguageBranchID=@LangBranchID OR tblPageDefinition.LanguageSpecific<3)
	AND NOT EXISTS
		(SELECT * FROM tblProperty 
		WHERE fkPageDefinitionID=tblPageDefinition.pkID 
		AND tblProperty.fkPageID=tblPage.pkID)

END
GO
PRINT N'Creating [dbo].[netPropertySearchValueMeta]...';


GO
CREATE PROCEDURE [dbo].[netPropertySearchValueMeta]
(
	@PageID			INT,
	@PropertyName 	NVARCHAR(255),
	@Equals			BIT = 0,
	@NotEquals		BIT = 0,
	@GreaterThan	BIT = 0,
	@LessThan		BIT = 0,
	@Boolean		BIT = NULL,
	@Number			INT = NULL,
	@FloatNumber	FLOAT = NULL,
	@PageType		INT = NULL,
	@PageLink		INT = NULL,
	@Date			DATETIME = NULL,
	@LanguageBranch	NCHAR(17) = NULL
)
AS
BEGIN
	DECLARE @LangBranchID NCHAR(17)
	SELECT @LangBranchID=pkID FROM tblLanguageBranch WHERE LanguageID=@LanguageBranch
	IF @LangBranchID IS NULL 
	BEGIN 
		if @LanguageBranch IS NOT NULL
			RAISERROR('Language branch %s is not defined',16,1, @LanguageBranch)
		else
			SET @LangBranchID = -1
	END
	
	DECLARE @DynSql NVARCHAR(2000)
	DECLARE @compare NVARCHAR(2)
	
	IF (@Equals = 1)
	BEGIN
	    SET @compare = '='
	END
	ELSE IF (@GreaterThan = 1)
	BEGIN
	    SET @compare = '>'
	END
	ELSE IF (@LessThan = 1)
	BEGIN
	    SET @compare = '<'
	END
	ELSE IF (@NotEquals = 1)
	BEGIN
	    SET @compare = '<>'
	END
	ELSE
	BEGIN
	    RAISERROR('No compare condition is defined.',16,1)
	END
	
	SET @DynSql = 'SELECT PageLanguages.fkPageID FROM tblPageLanguage as PageLanguages INNER JOIN tblTree ON tblTree.fkChildID=PageLanguages.fkPageID INNER JOIN tblContent as Pages ON Pages.pkID=PageLanguages.fkPageID'

	IF (@PropertyName = 'PageArchiveLink')
	BEGIN
		SET @DynSql = @DynSql + ' LEFT OUTER JOIN tblContent as Pages2 ON Pages.ArchiveContentGUID = Pages2.ContentGUID'
	END
	
	IF (@PropertyName = 'PageShortcutLink')
	BEGIN
		SET @DynSql = @DynSql + ' LEFT OUTER JOIN tblContent as Pages2 ON PageLanguages.PageLinkGUID = Pages2.ContentGUID'
	END
	
	SET @DynSql = @DynSql + ' WHERE Pages.ContentType = 0 AND tblTree.fkParentID=@PageID'

	IF (@LangBranchID <> -1)
	BEGIN
	    SET @DynSql = @DynSql + ' AND PageLanguages.fkLanguageBranchID=@LangBranchID'
	END
	
	IF (@PropertyName = 'PageVisibleInMenu')
	BEGIN
	    SET @DynSql = @DynSql + ' AND Pages.VisibleInMenu=@Boolean'
	END
	ELSE IF (@PropertyName = 'PageTypeID')
	BEGIN
	    IF (@Equals=1)
	        SET @DynSql = @DynSql + ' AND (Pages.fkContentTypeID = @PageType OR (@PageType IS NULL AND Pages.fkContentTypeID IS NULL))'
	    ELSE
	        SET @DynSql = @DynSql + ' AND (Pages.fkContentTypeID' + @compare + '@PageType OR (@PageType IS NULL AND NOT Pages.fkContentTypeID IS NULL))'
	END
	ELSE IF (@PropertyName = 'PageLink')
	BEGIN
	    IF (@Equals=1)
	        SET @DynSql = @DynSql + ' AND (PageLanguages.fkPageID = @PageLink OR (@PageLink IS NULL AND PageLanguages.fkPageID IS NULL))'
	    ELSE
	        SET @DynSql = @DynSql + ' AND (PageLanguages.fkPageID' + @compare + '@PageLink OR (@PageLink IS NULL AND NOT PageLanguages.fkPageID IS NULL))'
	END
	ELSE IF (@PropertyName = 'PageParentLink')
	BEGIN
	    IF (@Equals=1)
	        SET @DynSql = @DynSql + ' AND (Pages.fkParentID = @PageLink OR (@PageLink IS NULL AND Pages.fkParentID IS NULL))'
	    ELSE
	        SET @DynSql = @DynSql + ' AND (Pages.fkParentID' + @compare + '@PageLink OR (@PageLink IS NULL AND NOT Pages.fkParentID IS NULL))'
	END
	ELSE IF (@PropertyName = 'PageShortcutLink')
	BEGIN
		SET @DynSql = @DynSql + ' AND (Pages2.pkID' + @compare + '@PageLink OR (@PageLink IS NULL AND NOT PageLanguages.PageLinkGUID IS NULL))'
	END
	ELSE IF (@PropertyName = 'PageArchiveLink')
	BEGIN
		SET @DynSql = @DynSql + ' AND (Pages2.pkID' + @compare + '@PageLink OR (@PageLink IS NULL AND NOT Pages.ArchiveContentGUID IS NULL))'
	END
	ELSE IF (@PropertyName = 'PageChanged')
	BEGIN
	    IF (@Equals=1)
	        SET @DynSql = @DynSql + ' AND (PageLanguages.Changed = @Date OR (@Date IS NULL AND PageLanguages.Changed IS NULL))'
	    ELSE
	        SET @DynSql = @DynSql + ' AND (PageLanguages.Changed' + @compare + '@Date OR (@Date IS NULL AND NOT PageLanguages.Changed IS NULL))'
	END
	ELSE IF (@PropertyName = 'PageCreated')
	BEGIN
	    IF (@Equals=1)
	        SET @DynSql = @DynSql + ' AND (PageLanguages.Created = @Date OR (@Date IS NULL AND PageLanguages.Created IS NULL))'
	    ELSE
	        SET @DynSql = @DynSql + ' AND (PageLanguages.Created' + @compare + '@Date OR (@Date IS NULL AND NOT PageLanguages.Created IS NULL))'
	END
	ELSE IF (@PropertyName = 'PageSaved')
	BEGIN
	    IF (@Equals=1)
	        SET @DynSql = @DynSql + ' AND (PageLanguages.Saved = @Date OR (@Date IS NULL AND PageLanguages.Saved IS NULL))'
	    ELSE
	        SET @DynSql = @DynSql + ' AND (PageLanguages.Saved' + @compare + '@Date  OR (@Date IS NULL AND NOT PageLanguages.Saved IS NULL))'
	END
	ELSE IF (@PropertyName = 'PageStartPublish')
	BEGIN
	    IF (@Equals=1)
	        SET @DynSql = @DynSql + ' AND (PageLanguages.StartPublish = @Date OR (@Date IS NULL AND PageLanguages.StartPublish IS NULL))'
	    ELSE
	        SET @DynSql = @DynSql + ' AND (PageLanguages.StartPublish' + @compare + '@Date OR (@Date IS NULL AND NOT PageLanguages.StartPublish IS NULL))'
	END
	ELSE IF (@PropertyName = 'PageStopPublish')
	BEGIN
	    IF (@Equals=1)
	        SET @DynSql = @DynSql + ' AND (PageLanguages.StopPublish = @Date OR (@Date IS NULL AND PageLanguages.StopPublish IS NULL))'
	    ELSE
	        SET @DynSql = @DynSql + ' AND (PageLanguages.StopPublish' + @compare + '@Date OR (@Date IS NULL AND NOT PageLanguages.StopPublish IS NULL))'
	END
	ELSE IF (@PropertyName = 'PageDeleted')
	BEGIN
		SET @DynSql = @DynSql + ' AND Pages.Deleted = @Boolean'
	END
	ELSE IF (@PropertyName = 'PagePendingPublish')
	BEGIN
		SET @DynSql = @DynSql + ' AND PageLanguages.PendingPublish = @Boolean'
	END
	ELSE IF (@PropertyName = 'PageFolderID')
	BEGIN
	    IF (@Equals=1)
	        SET @DynSql = @DynSql + ' AND (Pages.ExternalFolderID = @Number OR (@Number IS NULL AND Pages.ExternalFolderID IS NULL))'
	    ELSE
	        SET @DynSql = @DynSql + ' AND (Pages.ExternalFolderID' + @compare + '@Number OR (@Number IS NULL AND NOT Pages.ExternalFolderID IS NULL))'
	END
	ELSE IF (@PropertyName = 'PageShortcutType')
	BEGIN
	    IF (@Number=0)
	        SET @DynSql = @DynSql + ' AND PageLanguages.AutomaticLink=1 AND PageLanguages.PageLinkGUID IS NULL'
	    ELSE IF (@Number=1)
	        SET @DynSql = @DynSql + ' AND PageLanguages.AutomaticLink=1 AND NOT PageLanguages.PageLinkGUID IS NULL AND PageLanguages.FetchData=0'
	    ELSE IF (@Number=2)
	        SET @DynSql = @DynSql + ' AND PageLanguages.AutomaticLink=0 AND PageLanguages.LinkURL<>N''#'''
	    ELSE IF (@Number=3)
	        SET @DynSql = @DynSql + ' AND PageLanguages.AutomaticLink=0 AND PageLanguages.LinkURL=N''#'''
	    ELSE IF (@Number=4)
	        SET @DynSql = @DynSql + ' AND PageLanguages.AutomaticLink=1 AND PageLanguages.FetchData=1'
	END

	EXEC sp_executesql @DynSql, 
		N'@PageID INT, @LangBranchID NCHAR(17), @Boolean BIT, @Number INT, @PageType INT, @PageLink INT, @Date DATETIME',
		@PageID=@PageID,
		@LangBranchID=@LangBranchID, 
		@Boolean=@Boolean,
		@Number=@Number,
		@PageType=@PageType,
		@PageLink=@PageLink,
		@Date=@Date
END
GO
PRINT N'Creating [dbo].[netPropertySearchValue]...';


GO
CREATE PROCEDURE dbo.netPropertySearchValue
(
	@PageID			INT,
	@PropertyName 	NVARCHAR(255),
	@Equals			BIT = 0,
	@NotEquals		BIT = 0,
	@GreaterThan	BIT = 0,
	@LessThan		BIT = 0,
	@Boolean		BIT = NULL,
	@Number			INT = NULL,
	@FloatNumber	FLOAT = NULL,
	@PageType		INT = NULL,
	@PageLink		INT = NULL,
	@Date			DATETIME = NULL,
	@LanguageBranch	NCHAR(17) = NULL
)
AS
BEGIN
	DECLARE @LangBranchID NCHAR(17);

	SELECT @LangBranchID=pkID FROM tblLanguageBranch WHERE LanguageID=@LanguageBranch
	IF @LangBranchID IS NULL 
	BEGIN 
		if @LanguageBranch IS NOT NULL
			RAISERROR('Language branch %s is not defined',16,1, @LanguageBranch)
		else
			SET @LangBranchID = -1
	END
		
	IF NOT @Boolean IS NULL
		SELECT DISTINCT(tblProperty.fkPageID)
		FROM       tblProperty
		INNER JOIN tblPageDefinition ON tblPageDefinition.pkID=tblProperty.fkPageDefinitionID
		INNER JOIN tblPageType ON tblPageDefinition.fkPageTypeID=tblPageType.pkID
		INNER JOIN tblTree ON tblTree.fkChildID=tblProperty.fkPageID
		INNER JOIN tblPageLanguage on tblPageLanguage.fkPageID=tblProperty.fkPageID
		WHERE tblPageType.ContentType = 0
		AND tblTree.fkParentID=@PageID 
		AND tblPageDefinition.Name=@PropertyName
		AND Property = 0
		AND Boolean = @Boolean
		AND (@LangBranchID=-1 OR tblProperty.fkLanguageBranchID=@LangBranchID OR tblPageDefinition.LanguageSpecific<3)

	ELSE IF NOT @Number IS NULL
		SELECT DISTINCT(tblProperty.fkPageID)
		FROM       tblProperty
		INNER JOIN tblPageDefinition ON tblPageDefinition.pkID=tblProperty.fkPageDefinitionID
		INNER JOIN tblPageType ON tblPageDefinition.fkPageTypeID=tblPageType.pkID
		INNER JOIN tblTree ON tblTree.fkChildID=tblProperty.fkPageID
		INNER JOIN tblPageLanguage on tblPageLanguage.fkPageID=tblProperty.fkPageID
		WHERE tblPageType.ContentType = 0
		AND tblTree.fkParentID=@PageID 
		AND tblPageDefinition.Name=@PropertyName
		AND Property = 1
		AND (@LangBranchID=-1 OR tblProperty.fkLanguageBranchID=@LangBranchID OR tblPageDefinition.LanguageSpecific<3)
		AND 
		(
			(@Equals=1 		AND (Number = @Number OR (@Number IS NULL AND Number IS NULL)))
			OR
			(@GreaterThan=1 	AND Number > @Number)
			OR
			(@LessThan=1 		AND Number < @Number)
			OR
			(@NotEquals=1		AND Number <> @Number)
		)
	ELSE IF NOT @FloatNumber IS NULL
		SELECT DISTINCT(tblProperty.fkPageID)
		FROM       tblProperty
		INNER JOIN tblPageDefinition ON tblPageDefinition.pkID=tblProperty.fkPageDefinitionID
		INNER JOIN tblPageType ON tblPageDefinition.fkPageTypeID=tblPageType.pkID
		INNER JOIN tblTree ON tblTree.fkChildID=tblProperty.fkPageID
		INNER JOIN tblPageLanguage on tblPageLanguage.fkPageID=tblProperty.fkPageID
		WHERE tblPageType.ContentType = 0
		AND tblTree.fkParentID=@PageID 
		AND tblPageDefinition.Name=@PropertyName
		AND Property = 2
		AND (@LangBranchID=-1 OR tblProperty.fkLanguageBranchID=@LangBranchID OR tblPageDefinition.LanguageSpecific<3)
		AND
		(
			(@Equals=1 		AND (FloatNumber = @FloatNumber OR (@FloatNumber IS NULL AND FloatNumber IS NULL)))
			OR
			(@GreaterThan=1 	AND FloatNumber > @FloatNumber)
			OR
			(@LessThan=1 		AND FloatNumber < @FloatNumber)
			OR
			(@NotEquals=1		AND FloatNumber <> @FloatNumber)
		)

	ELSE IF NOT @PageType IS NULL
		SELECT DISTINCT(tblProperty.fkPageID)
		FROM       tblProperty
		INNER JOIN tblPageDefinition ON tblPageDefinition.pkID=tblProperty.fkPageDefinitionID
		INNER JOIN tblPageType ON tblPageDefinition.fkPageTypeID=tblPageType.pkID
		INNER JOIN tblTree ON tblTree.fkChildID=tblProperty.fkPageID
		INNER JOIN tblPageLanguage on tblPageLanguage.fkPageID=tblProperty.fkPageID
		WHERE tblPageType.ContentType = 0
		AND tblTree.fkParentID=@PageID 
		AND tblPageDefinition.Name=@PropertyName
		AND Property = 3
		AND (@LangBranchID=-1 OR tblProperty.fkLanguageBranchID=@LangBranchID OR tblPageDefinition.LanguageSpecific<3)
		AND
		(
			(@Equals=1 		AND (PageType = @PageType OR (@PageType IS NULL AND PageType IS NULL)))
			OR
			(@GreaterThan=1 	AND PageType > @PageType)
			OR
			(@LessThan=1 		AND PageType < @PageType)
			OR
			(@NotEquals=1		AND PageType <> @PageType)
		)

	ELSE IF NOT @PageLink IS NULL
		SELECT DISTINCT(tblProperty.fkPageID)
		FROM       tblProperty
		INNER JOIN tblPageDefinition ON tblPageDefinition.pkID=tblProperty.fkPageDefinitionID
		INNER JOIN tblPageType ON tblPageDefinition.fkPageTypeID=tblPageType.pkID
		INNER JOIN tblTree ON tblTree.fkChildID=tblProperty.fkPageID
		INNER JOIN tblPageLanguage on tblPageLanguage.fkPageID=tblProperty.fkPageID
		WHERE tblPageType.ContentType = 0
		AND tblTree.fkParentID=@PageID 
		AND tblPageDefinition.Name=@PropertyName
		AND Property = 4
		AND (@LangBranchID=-1 OR tblProperty.fkLanguageBranchID=@LangBranchID OR tblPageDefinition.LanguageSpecific<3)
		AND
		(
			(@Equals=1 		AND (PageLink = @PageLink OR (@PageLink IS NULL AND PageLink IS NULL)))
			OR
			(@GreaterThan=1 	AND PageLink > @PageLink)
			OR
			(@LessThan=1 		AND PageLink < @PageLink)
			OR
			(@NotEquals=1		AND PageLink <> @PageLink)
		)

	ELSE IF NOT @Date IS NULL
		SELECT DISTINCT(tblProperty.fkPageID)
		FROM       tblProperty
		INNER JOIN tblPageDefinition ON tblPageDefinition.pkID=tblProperty.fkPageDefinitionID
		INNER JOIN tblPageType ON tblPageDefinition.fkPageTypeID=tblPageType.pkID
		INNER JOIN tblTree ON tblTree.fkChildID=tblProperty.fkPageID
		INNER JOIN tblPageLanguage on tblPageLanguage.fkPageID=tblProperty.fkPageID
		WHERE tblPageType.ContentType = 0
		AND tblTree.fkParentID=@PageID 
		AND tblPageDefinition.Name=@PropertyName
		AND Property = 5
		AND (@LangBranchID=-1 OR tblProperty.fkLanguageBranchID=@LangBranchID OR tblPageDefinition.LanguageSpecific<3)
		AND
		(
			(@Equals=1 		AND ([Date] = @Date OR (@Date IS NULL AND [Date] IS NULL)))

			OR
			(@GreaterThan=1 	AND [Date] > @Date)
			OR
			(@LessThan=1 		AND [Date] < @Date)
			OR
			(@NotEquals=1		AND [Date] <> @Date)
		)
	ELSE
		SELECT DISTINCT(tblProperty.fkPageID)
		FROM tblProperty
		INNER JOIN tblPageLanguage on tblPageLanguage.fkPageID=tblProperty.fkPageID
		INNER JOIN tblPageDefinition ON tblPageDefinition.pkID=tblProperty.fkPageDefinitionID
		INNER JOIN tblPageType ON tblPageDefinition.fkPageTypeID=tblPageType.pkID
		WHERE tblPageType.ContentType = 0
		AND (@LangBranchID=-1 OR tblProperty.fkLanguageBranchID=@LangBranchID OR tblPageDefinition.LanguageSpecific<3)
END
GO
PRINT N'Creating [dbo].[netPropertySearchStringMeta]...';


GO
CREATE PROCEDURE dbo.netPropertySearchStringMeta
(
	@PageID				INT,
	@PropertyName 		NVARCHAR(255),
	@UseWildCardsBefore	BIT = 0,
	@UseWildCardsAfter	BIT = 0,
	@String				NVARCHAR(2000) = NULL,
	@LanguageBranch		NCHAR(17) = NULL
)
AS
BEGIN
	DECLARE @SearchString NVARCHAR(2010)
	DECLARE @DynSqlSelect NVARCHAR(2000)
	DECLARE @DynSqlWhere NVARCHAR(2000)
	DECLARE @LangBranchID NCHAR(17)
    
	
	SELECT @LangBranchID=pkID FROM tblLanguageBranch WHERE LanguageID=@LanguageBranch
	IF @LangBranchID IS NULL 
	BEGIN 
		IF @LanguageBranch IS NOT NULL
			RAISERROR('Language branch %s is not defined',16,1, @LanguageBranch)
		ELSE
			SET @LangBranchID = -1
	END
			
	SELECT @SearchString=CASE    WHEN @UseWildCardsBefore=0 AND @UseWildCardsAfter=0 THEN @String
						WHEN @UseWildCardsBefore=1 AND @UseWildCardsAfter=0 THEN N'%' + @String
						WHEN @UseWildCardsBefore=0 AND @UseWildCardsAfter=1 THEN @String + N'%'
						ELSE N'%' + @String + N'%'
					END

	SET @DynSqlSelect = 'SELECT tblPageLanguage.fkPageID FROM tblPageLanguage INNER JOIN tblTree ON tblTree.fkChildID=tblPageLanguage.fkPageID INNER JOIN tblContent as tblPage ON tblPageLanguage.fkPageID=tblPage.pkID'
	SET @DynSqlWhere = ' WHERE tblPage.ContentType = 0 AND tblTree.fkParentID=@PageID'

	IF (@LangBranchID <> -1)
		SET @DynSqlWhere = @DynSqlWhere + ' AND tblPageLanguage.fkLanguageBranchID=@LangBranchID'

	IF (@PropertyName = 'PageName')
	BEGIN
		IF (@String IS NULL)
			SET @DynSqlWhere = @DynSqlWhere + ' AND tblPageLanguage.Name IS NULL'
		ELSE
			SET @DynSqlWhere = @DynSqlWhere + ' AND tblPageLanguage.Name LIKE @SearchString'
	END
	ELSE IF (@PropertyName = 'PageLinkURL')
	BEGIN
		IF (@String IS NULL)
			SET @DynSqlWhere = @DynSqlWhere + ' AND tblPageLanguage.LinkURL IS NULL'
		ELSE
			SET @DynSqlWhere = @DynSqlWhere + ' AND tblPageLanguage.LinkURL LIKE @SearchString'
	END
	ELSE IF (@PropertyName = 'PageCreatedBy')
	BEGIN
		IF (@String IS NULL)
			SET @DynSqlWhere = @DynSqlWhere + ' AND tblPageLanguage.CreatorName IS NULL'
		ELSE
			SET @DynSqlWhere = @DynSqlWhere + ' AND tblPageLanguage.CreatorName LIKE @SearchString'
	END
	ELSE IF (@PropertyName = 'PageChangedBy')
	BEGIN
		IF (@String IS NULL)
			SET @DynSqlWhere = @DynSqlWhere + ' AND tblPageLanguage.ChangedByName IS NULL'
		ELSE
			SET @DynSqlWhere = @DynSqlWhere + ' AND tblPageLanguage.ChangedByName LIKE @SearchString'
	END
	ELSE IF (@PropertyName = 'PageTypeName')
	BEGIN
		SET @DynSqlSelect = @DynSqlSelect + ' INNER JOIN tblPageType ON tblPageType.pkID=tblPage.fkContentTypeID'

		IF (@String IS NULL)
			SET @DynSqlWhere = @DynSqlWhere + ' AND tblPageType.Name IS NULL'
		ELSE
			SET @DynSqlWhere = @DynSqlWhere + ' AND tblPageType.Name LIKE @SearchString'
	END
	ELSE IF (@PropertyName = 'PageExternalURL')
	BEGIN
		IF (@String IS NULL)
			SET @DynSqlWhere = @DynSqlWhere + ' AND tblPageLanguage.ExternalURL IS NULL'
		ELSE
			SET @DynSqlWhere = @DynSqlWhere + ' AND tblPageLanguage.ExternalURL LIKE @SearchString'
	END
	ELSE IF (@PropertyName = 'PageLanguageBranch')
	BEGIN
        SET @DynSqlSelect = @DynSqlSelect + ' INNER JOIN tblLanguageBranch ON tblLanguageBranch.pkid = tblPageLanguage.fklanguagebranchid'
		IF (@String IS NULL)
			SET @DynSqlWhere = @DynSqlWhere + ' AND tblLanguageBranch.languageid IS NULL'
		ELSE
			SET @DynSqlWhere = @DynSqlWhere + ' AND RTRIM(tblLanguageBranch.languageid) LIKE @SearchString'
	END
	ELSE IF (@PropertyName = 'PageShortcutLink')
	BEGIN
	    IF (@String IS NULL)
	        SET @DynSqlWhere = @DynSqlWhere + ' AND tblPageLanguage.PageLinkGUID IS NULL' 
	    ELSE
	        SET @DynSqlWhere = @DynSqlWhere + ' AND tblPageLanguage.PageLinkGUID LIKE @SearchString'
	END
	ELSE IF (@PropertyName = 'PageArchiveLink')
	BEGIN
	    IF (@String IS NULL)
	        SET @DynSqlWhere = @DynSqlWhere + ' AND tblPage.ArchiveContentGUID IS NULL' 
	    ELSE
	        SET @DynSqlWhere = @DynSqlWhere + ' AND tblPage.ArchiveContentGUID LIKE @SearchString'
	END
	ELSE IF (@PropertyName = 'PageURLSegment')
	BEGIN
	    IF (@String IS NULL)
	        SET @DynSqlWhere = @DynSqlWhere + ' AND tblPageLanguage.URLSegment IS NULL' 
	    ELSE
	        SET @DynSqlWhere = @DynSqlWhere + ' AND tblPageLanguage.URLSegment LIKE @SearchString'
	END

	SET @DynSqlSelect = @DynSqlSelect + @DynSqlWhere
	EXEC sp_executesql @DynSqlSelect, 
		N'@PageID INT, @LangBranchID NCHAR(17), @SearchString NVARCHAR(2010)',
		@PageID=@PageID,
		@LangBranchID=@LangBranchID, 
		@SearchString=@SearchString
END
GO
PRINT N'Creating [dbo].[netPropertySearchString]...';


GO
CREATE PROCEDURE dbo.netPropertySearchString
(
	@PageID				INT,
	@PropertyName 		NVARCHAR(255),
	@UseWildCardsBefore	BIT = 0,
	@UseWildCardsAfter	BIT = 0,
	@String				NVARCHAR(2000) = NULL,
	@LanguageBranch		NCHAR(17) = NULL
)
AS
BEGIN
	DECLARE @LangBranchID INT
	DECLARE @Path VARCHAR(7000)
	DECLARE @SearchString NVARCHAR(2002)

	SELECT @LangBranchID=pkID FROM tblLanguageBranch WHERE LanguageID=@LanguageBranch
	IF @LangBranchID IS NULL 
	BEGIN 
		if @LanguageBranch IS NOT NULL
			RAISERROR('Language branch %s is not defined',16,1, @LanguageBranch)
		else
			SET @LangBranchID = -1
	END

	SELECT @Path=PagePath + CONVERT(VARCHAR, @PageID) + '.' FROM tblPage WHERE pkID=@PageID
		

	SET @SearchString=CASE    
		WHEN @UseWildCardsBefore=0 AND @UseWildCardsAfter=0 THEN @String
		WHEN @UseWildCardsBefore=1 AND @UseWildCardsAfter=0 THEN '%' + @String
		WHEN @UseWildCardsBefore=0 AND @UseWildCardsAfter=1 THEN @String + '%'
		ELSE '%' + @String + '%'
	END

	SELECT P.pkID
	FROM tblContent AS P
	INNER JOIN tblProperty ON tblProperty.fkPageID=P.pkID
	INNER JOIN tblPageLanguage ON tblPageLanguage.fkPageID=P.pkID
	INNER JOIN tblPageDefinition ON tblPageDefinition.pkID = tblProperty.fkPageDefinitionID and tblPageDefinition.Name = @PropertyName and tblPageDefinition.Property in (6,7)
	WHERE 
		P.ContentType = 0 
	AND
		CHARINDEX(@Path, P.ContentPath) = 1
	AND 
		(@LangBranchID=-1 OR tblProperty.fkLanguageBranchID=@LangBranchID OR tblPageDefinition.LanguageSpecific<3)
	AND
	(
		(@String IS NULL AND (String IS NULL AND LongString IS NULL))
				OR
		(tblPageDefinition.Property=6 AND String LIKE @SearchString)
				OR
		(tblPageDefinition.Property=7 AND LongString LIKE @SearchString)
	)
END
GO
PRINT N'Creating [dbo].[netPropertySearch]...';


GO
CREATE PROCEDURE dbo.netPropertySearch
(
	@PageID			INT,
	@FindProperty	NVARCHAR(255),
	@NotProperty	NVARCHAR(255),
	@LanguageBranch	NCHAR(17) = NULL
)
AS
BEGIN
	DECLARE @LangBranchID NCHAR(17);
	SELECT @LangBranchID=pkID FROM tblLanguageBranch WHERE LanguageID=@LanguageBranch
	IF @LangBranchID IS NULL 
	BEGIN 
		if @LanguageBranch IS NOT NULL
			RAISERROR('Language branch %s is not defined',16,1, @LanguageBranch)
		else
			SET @LangBranchID = -1
	END
		
	SET NOCOUNT ON
	/* All levels */
	SELECT
		tblPage.pkID
	FROM 
		tblPage
	INNER JOIN
		tblTree ON tblTree.fkChildID=tblPage.pkID
	INNER JOIN
		tblPageType ON tblPage.fkPageTypeID=tblPageType.pkID
	INNER JOIN
		tblPageDefinition ON tblPageType.pkID=tblPageDefinition.fkPageTypeID 
		AND tblPageDefinition.Name=@FindProperty
	INNER JOIN
		tblProperty ON tblProperty.fkPageID=tblPage.pkID 
		AND tblPageDefinition.pkID=tblProperty.fkPageDefinitionID
	INNER JOIN 
		tblPageLanguage ON tblPageLanguage.fkPageID=tblPage.pkID
	WHERE
		tblPageType.ContentType = 0 AND
		tblTree.fkParentID=@PageID AND
		tblPage.Deleted = 0 AND
		tblPageLanguage.[Status] = 4 AND
		(@LangBranchID=-1 OR tblPageLanguage.fkLanguageBranchID=@LangBranchID OR tblPageDefinition.LanguageSpecific<3) AND
		(@NotProperty IS NULL OR NOT EXISTS(
			SELECT * FROM tblProperty 
			INNER JOIN tblPageDefinition ON tblPageDefinition.pkID=tblProperty.fkPageDefinitionID 
			WHERE tblPageDefinition.Name=@NotProperty 
			AND tblProperty.fkPageID=tblPage.pkID))
	ORDER BY tblPageLanguage.Name ASC
END
GO
PRINT N'Creating [dbo].[netPropertySave]...';


GO
CREATE PROCEDURE [dbo].[netPropertySave]
(
	@PageID				INT,
	@WorkPageID			INT,
	@PageDefinitionID	INT,
	@Override			BIT,
	@LanguageBranch		NCHAR(17) = NULL,
	@ScopeName			NVARCHAR(450) = NULL,
--Per Type:
	@Number				INT = NULL,
	@Boolean			BIT = 0,
	@Date				DATETIME = NULL,
	@FloatNumber		FLOAT = NULL,
	@PageType			INT = NULL,
	@String				NVARCHAR(450) = NULL,
	@LinkGuid			uniqueidentifier = NULL,
	@PageLink			INT = NULL,
	@LongString			NVARCHAR(MAX) = NULL


)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON

	DECLARE @LangBranchID NCHAR(17);
	IF (@WorkPageID <> 0)
		SELECT @LangBranchID = fkLanguageBranchID FROM tblWorkPage WHERE pkID = @WorkPageID
	ELSE
		SELECT @LangBranchID = pkID FROM tblLanguageBranch WHERE LanguageID = @LanguageBranch

	IF @LangBranchID IS NULL 
	BEGIN 
		if @LanguageBranch IS NOT NULL
			RAISERROR('Language branch %s is not defined',16,1, @LanguageBranch)
		else
			SET @LangBranchID = 1
	END

	DECLARE @IsLanguagePublished BIT;
	IF EXISTS(SELECT fkContentID FROM tblContentLanguage 
		WHERE fkContentID = @PageID AND fkLanguageBranchID = CAST(@LangBranchID AS INT) AND Status = 4)
		SET @IsLanguagePublished = 1
	ELSE
		SET @IsLanguagePublished = 0
	
	DECLARE @DynProp INT
	DECLARE @retval	INT
	SET @retval = 0
	
		SELECT
			@DynProp = pkID
		FROM
			tblPageDefinition
		WHERE
			pkID = @PageDefinitionID
		AND
			fkPageTypeID IS NULL

		IF (@WorkPageID IS NOT NULL)
		BEGIN
			/* Never store dynamic properties in work table */
			IF (@DynProp IS NOT NULL)
				GOTO cleanup
				
			/* Insert or update property */
			IF EXISTS(SELECT fkWorkPageID FROM tblWorkProperty 
				WHERE fkWorkPageID=@WorkPageID AND fkPageDefinitionID=@PageDefinitionID AND ((@ScopeName IS NULL AND ScopeName IS NULL) OR (@ScopeName = ScopeName)))
				UPDATE
					tblWorkProperty
				SET
					ScopeName = @ScopeName,
					Number = @Number,
					Boolean = @Boolean,
					[Date] = @Date,
					FloatNumber = @FloatNumber,
					PageType = @PageType,
					String = @String,
					LinkGuid = @LinkGuid,
					PageLink = @PageLink,
					LongString = @LongString
				WHERE
					fkWorkPageID = @WorkPageID
				AND
					fkPageDefinitionID = @PageDefinitionID
				AND 
					((@ScopeName IS NULL AND ScopeName IS NULL) OR (@ScopeName = ScopeName))
			ELSE
				INSERT INTO
					tblWorkProperty
					(fkWorkPageID,
					fkPageDefinitionID,
					ScopeName,
					Number,
					Boolean,
					[Date],
					FloatNumber,
					PageType,
					String,
					LinkGuid,
					PageLink,
					LongString)
				VALUES
					(@WorkPageID,
					@PageDefinitionID,
					@ScopeName,
					@Number,
					@Boolean,
					@Date,
					@FloatNumber,
					@PageType,
					@String,
					@LinkGuid,
					@PageLink,
					@LongString)
		END
		
		/* For published or languages where no version is published we save value in tblProperty as well. Reason for this is that if when page is loaded
		through tblProperty (typically netPageListPaged) the page gets populated correctly. */
		IF (@WorkPageID IS NULL OR @IsLanguagePublished = 0)
		BEGIN
			/* Insert or update property */
			IF EXISTS(SELECT fkPageID FROM tblProperty 
				WHERE fkPageID = @PageID AND fkPageDefinitionID = @PageDefinitionID  AND
					((@ScopeName IS NULL AND ScopeName IS NULL) OR (@ScopeName = ScopeName)) AND @LangBranchID = tblProperty.fkLanguageBranchID)
				UPDATE
					tblProperty
				SET
					ScopeName = @ScopeName,
					Number = @Number,
					Boolean = @Boolean,
					[Date] = @Date,
					FloatNumber = @FloatNumber,
					PageType = @PageType,
					String = @String,
					LinkGuid = @LinkGuid,
					PageLink = @PageLink,
					LongString = @LongString
				WHERE
					fkPageID = @PageID
				AND
					fkPageDefinitionID = @PageDefinitionID
				AND 
					((@ScopeName IS NULL AND ScopeName IS NULL) OR (@ScopeName = ScopeName))
				AND
					@LangBranchID = tblProperty.fkLanguageBranchID
			ELSE
				INSERT INTO
					tblProperty
					(fkPageID,
					fkPageDefinitionID,
					ScopeName,
					Number,
					Boolean,
					[Date],
					FloatNumber,
					PageType,
					String,
					LinkGuid,
					PageLink,
					LongString,
					fkLanguageBranchID)
				VALUES
					(@PageID,
					@PageDefinitionID,
					@ScopeName,
					@Number,
					@Boolean,
					@Date,
					@FloatNumber,
					@PageType,
					@String,
					@LinkGuid,
					@PageLink,
					@LongString,
					@LangBranchID)
				
			/* Override dynamic property definitions below the current level */
			IF (@DynProp IS NOT NULL)
			BEGIN
				IF (@Override = 1)
					DELETE FROM
						tblProperty
					WHERE
						fkPageDefinitionID = @PageDefinitionID
					AND
					(	
						@LanguageBranch IS NULL
					OR
						@LangBranchID = tblProperty.fkLanguageBranchID
					)
					AND
						fkPageID
					IN
						(SELECT fkChildID FROM tblTree WHERE fkParentID = @PageID)
				SET @retval = 1
			END
		END
cleanup:		
		
	RETURN @retval
END
GO
PRINT N'Creating [dbo].[netPropertyDefinitionTypeSave]...';


GO
CREATE PROCEDURE [dbo].[netPropertyDefinitionTypeSave]
(
	@ID 			INT OUTPUT,
	@Property 		INT,
	@Name 			NVARCHAR(255),
	@TypeName 		NVARCHAR(255) = NULL,
	@AssemblyName 	NVARCHAR(255) = NULL,
	@BlockTypeID	uniqueidentifier = NULL
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON

	/* In case several sites start up at sametime, e.g. in enterprise it may occour that both sites tries to insert at same time. 
	Therefore a check is made to see it it already exist an entry with same guid, and if so an update is performed instead of insert.*/
	IF @ID <= 0
	BEGIN
		SET @ID = ISNULL((SELECT pkID FROM tblPropertyDefinitionType WHERE fkContentTypeGUID = @BlockTypeID), @ID)
	END

	IF @ID<0
	BEGIN
		IF @AssemblyName='EPiServer'
			SELECT @ID = Max(pkID)+1 FROM tblPropertyDefinitionType WHERE pkID<1000
		ELSE
			SELECT @ID = CASE WHEN Max(pkID)<1000 THEN 1000 ELSE Max(pkID)+1 END FROM tblPropertyDefinitionType
		INSERT INTO tblPropertyDefinitionType
		(
			pkID,
			Property,
			Name,
			TypeName,
			AssemblyName,
			fkContentTypeGUID
		)
		VALUES
		(
			@ID,
			@Property,
			@Name,
			@TypeName,
			@AssemblyName,
			@BlockTypeID
		)
	END
	ELSE
		UPDATE tblPropertyDefinitionType SET
			Name 		= @Name,
			Property		= @Property,
			TypeName 	= @TypeName,
			AssemblyName 	= @AssemblyName,
			fkContentTypeGUID = @BlockTypeID
		WHERE pkID=@ID
		
END
GO
PRINT N'Creating [dbo].[netPropertyDefinitionGetUsage]...';


GO
CREATE PROCEDURE [dbo].[netPropertyDefinitionGetUsage]
(
	@PropertyDefinitionID	INT,
	@OnlyNoneMasterLanguage	BIT = 0,
	@OnlyPublished	BIT = 0
)
AS
BEGIN
	
	
	SET NOCOUNT ON
	
	--Get blocktype if property is block property
	DECLARE @ContentTypeID INT;
	SET @ContentTypeID = (SELECT tblContentType.pkID FROM 
		tblPropertyDefinition
		INNER JOIN tblPropertyDefinitionType ON tblPropertyDefinition.fkPropertyDefinitionTypeID = tblPropertyDefinitionType.pkID
		INNER JOIN tblContentType ON tblPropertyDefinitionType.fkContentTypeGUID = tblContentType.ContentTypeGUID
		WHERE tblPropertyDefinition.pkID = @PropertyDefinitionID);
	
	IF (@OnlyPublished = 1)
	BEGIN
		IF (@ContentTypeID IS NOT NULL)
		BEGIN
			SELECT DISTINCT
				tblContentLanguage.fkContentID as ContentID, 
				0 AS WorkID,
				tblContentLanguage.Name,
				tblLanguageBranch.LanguageID AS LanguageBranch,
				tblLanguageBranch.Name AS LanguageBranchName
			FROM 
				tblContentProperty 
			INNER JOIN 
				dbo.GetExistingScopesForDefinition(@PropertyDefinitionID) as ExistingScopes ON tblContentProperty.ScopeName = ExistingScopes.ScopeName
			INNER JOIN 
				tblContentLanguage ON tblContentProperty.fkContentID=tblContentLanguage.fkContentID
			INNER JOIN
				tblContent ON tblContent.pkID=tblContentLanguage.fkContentID
			INNER JOIN
				tblLanguageBranch ON tblLanguageBranch.pkID=tblContentLanguage.fkLanguageBranchID
			WHERE
				tblContentLanguage.fkLanguageBranchID=tblContentProperty.fkLanguageBranchID AND
				(@OnlyNoneMasterLanguage=0 OR tblContentProperty.fkLanguageBranchID<>tblContent.fkMasterLanguageBranchID)
		END
		ELSE
		BEGIN
			SELECT DISTINCT
				tblContentLanguage.fkContentID as ContentID, 
				0 AS WorkID,
				tblContentLanguage.Name,
				tblLanguageBranch.LanguageID AS LanguageBranch,
				tblLanguageBranch.Name AS LanguageBranchName
			FROM 
				tblContentProperty
			INNER JOIN 
				tblContentLanguage ON tblContentProperty.fkContentID=tblContentLanguage.fkContentID
			INNER JOIN
				tblContent ON tblContent.pkID=tblContentLanguage.fkContentID
			INNER JOIN
				tblLanguageBranch ON tblLanguageBranch.pkID=tblContentLanguage.fkLanguageBranchID
			WHERE
				tblContentLanguage.fkLanguageBranchID=tblContentProperty.fkLanguageBranchID AND
				tblContentProperty.fkPropertyDefinitionID=@PropertyDefinitionID AND
				(@OnlyNoneMasterLanguage=0 OR tblContentProperty.fkLanguageBranchID<>tblContent.fkMasterLanguageBranchID)
		END
	END
	ELSE
	BEGIN
		IF (@ContentTypeID IS NOT NULL)
		BEGIN
			SELECT DISTINCT
				tblContent.pkID as ContentID, 
				tblWorkContent.pkID AS WorkID,
				tblWorkContent.Name,
				tblLanguageBranch.LanguageID AS LanguageBranch
			FROM 
				tblWorkContentProperty
			INNER JOIN
				dbo.GetExistingScopesForDefinition(@PropertyDefinitionID) as ExistingScopes ON tblWorkContentProperty.ScopeName = ExistingScopes.ScopeName
			INNER JOIN
				tblWorkContent ON tblWorkContentProperty.fkWorkContentID=tblWorkContent.pkID
			INNER JOIN
				tblContent ON tblWorkContent.fkContentID=tblContent.pkID
			INNER JOIN 
				tblContentLanguage ON tblWorkContent.fkContentID=tblContentLanguage.fkContentID 
			INNER JOIN
				tblLanguageBranch ON tblLanguageBranch.pkID=tblContentLanguage.fkLanguageBranchID
			WHERE
				tblWorkContent.fkLanguageBranchID = tblLanguageBranch.pkID AND
				(@OnlyNoneMasterLanguage=0 OR tblWorkContent.fkLanguageBranchID<>tblContent.fkMasterLanguageBranchID)
		END
		ELSE
		BEGIN
			SELECT DISTINCT
				tblContent.pkID as ContentID, 
				tblWorkContent.pkID AS WorkID,
				tblWorkContent.Name,
				tblLanguageBranch.LanguageID AS LanguageBranch
			FROM 
				tblWorkContentProperty
			INNER JOIN
				tblWorkContent ON tblWorkContentProperty.fkWorkContentID=tblWorkContent.pkID
			INNER JOIN
				tblContent ON tblWorkContent.fkContentID=tblContent.pkID
			INNER JOIN 
				tblContentLanguage ON tblWorkContent.fkContentID=tblContentLanguage.fkContentID 
			INNER JOIN
				tblLanguageBranch ON tblLanguageBranch.pkID=tblContentLanguage.fkLanguageBranchID
			WHERE
				tblWorkContent.fkLanguageBranchID = tblLanguageBranch.pkID AND
				tblWorkContentProperty.fkPropertyDefinitionID=@PropertyDefinitionID AND
				(@OnlyNoneMasterLanguage=0 OR tblWorkContent.fkLanguageBranchID<>tblContent.fkMasterLanguageBranchID)
		END
	END

	RETURN 0
END
GO
PRINT N'Creating [dbo].[netPropertyDefinitionDelete]...';


GO
CREATE PROCEDURE [dbo].[netPropertyDefinitionDelete]
(
	@PropertyDefinitionID INT
)
AS
BEGIN
	DELETE FROM tblContentProperty WHERE ScopeName IN (SELECT ScopeName FROM dbo.GetExistingScopesForDefinition(@PropertyDefinitionID)) 
	DELETE FROM tblWorkContentProperty WHERE ScopeName IN (SELECT ScopeName FROM dbo.GetExistingScopesForDefinition(@PropertyDefinitionID))
	DELETE FROM tblPropertyDefault WHERE fkPageDefinitionID=@PropertyDefinitionID
	DELETE FROM tblProperty WHERE fkPageDefinitionID=@PropertyDefinitionID
	DELETE FROM tblWorkProperty WHERE fkPageDefinitionID=@PropertyDefinitionID
	DELETE FROM tblCategoryPage WHERE CategoryType=@PropertyDefinitionID
	DELETE FROM tblWorkCategory WHERE CategoryType=@PropertyDefinitionID
	DELETE FROM tblPageDefinition WHERE pkID=@PropertyDefinitionID
END
GO
PRINT N'Creating [dbo].[netPropertyDefinitionCheckUsage]...';


GO
CREATE PROCEDURE [dbo].[netPropertyDefinitionCheckUsage]
(
	@PropertyDefinitionID	INT,
	@OnlyNoneMasterLanguage	BIT = 0,
	@OnlyPublished	BIT = 0
)
AS
BEGIN
	
	SET NOCOUNT ON
	
	--Get blocktype if property is block property
	DECLARE @ContentTypeID INT;
	SET @ContentTypeID = (SELECT tblContentType.pkID FROM 
		tblPropertyDefinition
		INNER JOIN tblPropertyDefinitionType ON tblPropertyDefinition.fkPropertyDefinitionTypeID = tblPropertyDefinitionType.pkID
		INNER JOIN tblContentType ON tblPropertyDefinitionType.fkContentTypeGUID = tblContentType.ContentTypeGUID
		WHERE tblPropertyDefinition.pkID = @PropertyDefinitionID);
	
	IF (@OnlyPublished = 1)
	BEGIN
		IF (@ContentTypeID IS NOT NULL)
		BEGIN
			SELECT TOP 1
				tblContentLanguage.fkContentID as ContentID, 
				0 AS WorkID
			FROM 
				tblContentProperty 
			INNER JOIN 
				dbo.GetExistingScopesForDefinition(@PropertyDefinitionID) as ExistingScopes ON tblContentProperty.ScopeName = ExistingScopes.ScopeName
			INNER JOIN 
				tblContentLanguage ON tblContentProperty.fkContentID=tblContentLanguage.fkContentID
		END
		ELSE
		BEGIN
			SELECT TOP 1
				tblContentLanguage.fkContentID as ContentID, 
				0 AS WorkID
			FROM 
				tblContentProperty
			INNER JOIN 
				tblContentLanguage ON tblContentProperty.fkContentID=tblContentLanguage.fkContentID
			WHERE
				tblContentLanguage.fkLanguageBranchID=tblContentProperty.fkLanguageBranchID AND
				tblContentProperty.fkPropertyDefinitionID=@PropertyDefinitionID
		END
	END
	ELSE
	BEGIN
		IF (@ContentTypeID IS NOT NULL)
		BEGIN
			SELECT TOP 1
				tblWorkContent.fkContentID as ContentID, 
				tblWorkContent.pkID AS WorkID
			FROM 
				tblWorkContentProperty
			INNER JOIN
				dbo.GetExistingScopesForDefinition(@PropertyDefinitionID) as ExistingScopes ON tblWorkContentProperty.ScopeName = ExistingScopes.ScopeName
			INNER JOIN
				tblWorkContent ON tblWorkContentProperty.fkWorkContentID=tblWorkContent.pkID
		END
		ELSE
		BEGIN
			SELECT TOP 1
				tblWorkContent.fkContentID as ContentID, 
				tblWorkContent.pkID AS WorkID
			FROM 
				tblWorkContentProperty
			INNER JOIN
				tblWorkContent ON tblWorkContentProperty.fkWorkContentID=tblWorkContent.pkID
			WHERE
				tblWorkContentProperty.fkPropertyDefinitionID=@PropertyDefinitionID
		END
	END

	RETURN 0
END
GO
PRINT N'Creating [dbo].[netPlugInSynchronize]...';


GO
CREATE PROCEDURE dbo.netPlugInSynchronize
(
	@AssemblyName NVARCHAR(255),
	@TypeName NVARCHAR(255),
	@DefaultEnabled Bit
)
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @id INT

	SELECT @id = pkID FROM tblPlugIn WHERE AssemblyName=@AssemblyName AND TypeName=@TypeName
	IF @id IS NULL
	BEGIN
		INSERT INTO tblPlugIn(AssemblyName,TypeName,Enabled) VALUES(@AssemblyName,@TypeName,@DefaultEnabled)
		SET @id =  SCOPE_IDENTITY() 
	END
	SELECT pkID, TypeName, AssemblyName, Saved, Created, Enabled FROM tblPlugIn WHERE pkID = @id

END
GO
PRINT N'Creating [dbo].[netPlugInSaveSettings]...';


GO
CREATE PROCEDURE dbo.netPlugInSaveSettings
@PlugInID 		INT,
@Settings 		NVARCHAR(MAX)
AS
BEGIN

	UPDATE tblPlugIn SET
		Settings 	= @Settings,
		Saved		= GetDate()
	WHERE pkID = @PlugInID
END
GO
PRINT N'Creating [dbo].[netPlugInSave]...';


GO
CREATE PROCEDURE dbo.netPlugInSave
@PlugInID 		INT,
@Enabled 		BIT
AS
BEGIN

	UPDATE tblPlugIn SET
		Enabled 	= @Enabled,
		Saved		= GetDate()
	WHERE pkID = @PlugInID
END
GO
PRINT N'Creating [dbo].[netPlugInLoad]...';


GO
CREATE PROCEDURE dbo.netPlugInLoad
@PlugInID INT
AS
BEGIN

	SELECT pkID, AssemblyName, TypeName, Settings, Saved, Created, Enabled
	FROM tblPlugIn
	WHERE pkID = @PlugInID OR @PlugInID = -1

END
GO
PRINT N'Creating [dbo].[netPersonalRejectedList]...';


GO
CREATE PROCEDURE [dbo].[netPersonalRejectedList]
(
	@UserName NVARCHAR(255),
    @Offset INT = 0,
    @Count INT = 50,
    @LanguageBranch NCHAR(17) = NULL
)
AS
BEGIN
	SET NOCOUNT ON

    DECLARE @LangBranchID NCHAR(17);
	SELECT @LangBranchID = pkID FROM tblLanguageBranch WHERE LanguageID = @LanguageBranch
	IF @LangBranchID IS NULL 
	BEGIN 
		if @LanguageBranch IS NOT NULL
			RAISERROR('Language branch %s is not defined',16,1, @LanguageBranch)
		else
			SET @LangBranchID = -1
	END

	
	DECLARE @InvariantLangBranchID NCHAR(17);
	SELECT @InvariantLangBranchID = pkID FROM tblLanguageBranch WHERE LanguageID = ''

	-- Determine the first record and last record
	DECLARE @FirstRecord int, @LastRecord int

	SELECT @FirstRecord = @Offset
	SELECT @LastRecord = (@Offset + @Count + 1);


	WITH TempResult as
	(
		SELECT	ROW_NUMBER() OVER(ORDER BY W.Saved DESC) as RowNumber,
			W.fkContentID AS ContentID,
			W.pkID AS WorkID,
			1 AS VersionStatus,
			W.ChangedByName AS UserName,
			W.Saved AS ItemCreated,
			W.Name,
			W.fkLanguageBranchID as LanguageBranch,
			W.CommonDraft,
			W.fkMasterVersionID as MasterVersion,
			CASE WHEN C.fkMasterLanguageBranchID=W.fkLanguageBranchID THEN 1 ELSE 0 END AS IsMasterLanguageBranch
		FROM
			tblWorkContent AS W
		INNER JOIN
			tblContent AS C ON C.pkID=W.fkContentID
		WHERE
			W.ChangedByName=@UserName AND
			W.Status = 1 AND
			C.Deleted=0 AND
			(@LanguageBranch = NULL OR 
			W.fkLanguageBranchID = @LangBranchID OR
			W.fkLanguageBranchID = @InvariantLangBranchID)
	)
	SELECT  TOP (@LastRecord - 1) *
	FROM    TempResult
	WHERE   RowNumber > @FirstRecord AND
		  RowNumber < @LastRecord
   		
END
GO
PRINT N'Creating [dbo].[netPersonalNotReadyList]...';


GO
CREATE PROCEDURE [dbo].[netPersonalNotReadyList]
(
    @UserName NVARCHAR(255),
    @Offset INT = 0,
    @Count INT = 50,
    @LanguageBranch NCHAR(17) = NULL
)
AS

BEGIN	
	SET NOCOUNT ON

    DECLARE @LangBranchID NCHAR(17);
	SELECT @LangBranchID = pkID FROM tblLanguageBranch WHERE LanguageID = @LanguageBranch
	IF @LangBranchID IS NULL 
	BEGIN 
		if @LanguageBranch IS NOT NULL
			RAISERROR('Language branch %s is not defined',16,1, @LanguageBranch)
		else
			SET @LangBranchID = -1
	END

	DECLARE @InvariantLangBranchID NCHAR(17);
	SELECT @InvariantLangBranchID = pkID FROM tblLanguageBranch WHERE LanguageID = ''

	-- Determine the first record and last record
	DECLARE @FirstRecord int, @LastRecord int

	SELECT @FirstRecord = @Offset
	SELECT @LastRecord = (@Offset + @Count + 1);

	WITH TempResult as
	(
		SELECT	ROW_NUMBER() OVER(ORDER BY W.Saved DESC) as RowNumber,
			W.fkContentID AS ContentID,
			W.pkID AS WorkID,
			2 AS VersionStatus,
			W.ChangedByName AS UserName,
			W.Saved AS ItemCreated,
			W.Name,
			W.fkLanguageBranchID as LanguageBranch,
			W.CommonDraft,
			W.fkMasterVersionID as MasterVersion,
			CASE WHEN C.fkMasterLanguageBranchID=W.fkLanguageBranchID THEN 1 ELSE 0 END AS IsMasterLanguageBranch
		FROM
			tblWorkContent AS W
		INNER JOIN
			tblContent AS C ON C.pkID=W.fkContentID
		WHERE
			W.ChangedByName=@UserName AND
			W.Status = 2 AND
			C.Deleted=0 AND
            (@LanguageBranch = NULL OR 
			W.fkLanguageBranchID = @LangBranchID OR
			W.fkLanguageBranchID = @InvariantLangBranchID)
	)
	SELECT  TOP (@LastRecord - 1) *
	FROM    TempResult
	WHERE   RowNumber > @FirstRecord AND
		  RowNumber < @LastRecord
   		
END
GO
PRINT N'Creating [dbo].[netPersonalActivityList]...';


GO
CREATE PROCEDURE dbo.netPersonalActivityList
(
    @UserName NVARCHAR(255)
)
AS
BEGIN
	SET NOCOUNT ON
	
	/* Not ready */
	SELECT
		W.fkPageID AS PageID,
		W.pkID AS WorkID,
		0 AS VersionStatus,
		W.ChangedByName AS UserName,
		W.Saved AS ItemCreated
	FROM
		tblWorkPage AS W
	INNER JOIN
		tblPage AS P ON P.pkID=W.fkPageID
	WHERE
	    W.ChangedByName=@UserName AND
		W.HasBeenPublished=0 AND
		W.ReadyToPublish=0 AND
		W.Rejected=0 AND
		P.Deleted=0
		
	UNION
	
	/* Ready to publish */
	SELECT DISTINCT
		W.fkPageID AS PageID,
		W.pkID AS WorkID,
		1 AS VersionStatus,
		W.ChangedByName AS UserName,
		W.Saved AS ItemCreated
	FROM
		tblWorkPage AS W
	LEFT JOIN
		tblPage AS P ON P.pkID=W.fkPageID
	WHERE
		W.HasBeenPublished=0 AND
		W.ReadyToPublish=1 AND
		W.DelayedPublish=0 AND
		W.Rejected=0 AND
		P.Deleted=0 AND
		((P.PublishedVersion<>W.pkID) OR (P.PublishedVersion IS NULL))
			
	UNION
	
	/* Rejected pages */
	SELECT 
		W.fkPageID AS PageID,
		W.pkID AS WorkID,
		2 AS VersionStatus,
		W.ChangedByName AS UserName,
		W.Saved AS ItemCreated
	FROM
		tblWorkPage AS W
	INNER JOIN
		tblPage AS P ON P.pkID=W.fkPageID
	WHERE
	    W.ChangedByName=@UserName AND
		W.HasBeenPublished=0 AND
		W.Rejected=1 AND
		P.Deleted=0
		
	ORDER BY VersionStatus DESC, ItemCreated DESC
   		
END
GO
PRINT N'Creating [dbo].[netPermissionSave]...';


GO
CREATE PROCEDURE dbo.netPermissionSave
(
	@Name NVARCHAR(255) = NULL,
	@IsRole INT = NULL,
	@Permission INT,
	@ClearByName INT = NULL,
	@ClearByPermission INT = NULL
)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (NOT @ClearByName IS NULL)
		DELETE FROM 
		    tblUserPermission 
		WHERE 
		    Name=@Name AND 
		IsRole=@IsRole
		
	IF (NOT @ClearByPermission IS NULL)
		DELETE FROM 
		    tblUserPermission 
		WHERE 
		    Permission=@Permission	

    IF ((@Name IS NULL) OR (@IsRole IS NULL))
        RETURN
        
	IF (NOT EXISTS(SELECT Name FROM tblUserPermission WHERE Name=@Name AND IsRole=@IsRole AND Permission=@Permission))
		INSERT INTO tblUserPermission 
		    (Name, 
		    IsRole, 
		    Permission) 
		VALUES 
		    (@Name, 
		    @IsRole, 
		    @Permission)
END
GO
PRINT N'Creating [dbo].[netPermissionRoles]...';


GO
CREATE PROCEDURE dbo.netPermissionRoles
(
	@Permission	INT
)
AS
BEGIN
    SET NOCOUNT ON
    SELECT
        Name,
        IsRole
    FROM
        tblUserPermission
    WHERE
        Permission=@Permission
    ORDER BY
        IsRole
END
GO
PRINT N'Creating [dbo].[netPermissionDeleteMembership]...';


GO
CREATE PROCEDURE [dbo].[netPermissionDeleteMembership]
(
	@Name	NVARCHAR(255) = NULL,
	@IsRole int = NULL
)
AS
BEGIN
    SET NOCOUNT ON
	IF(@Name IS NOT NULL AND @IsRole IS NOT NULL)
	BEGIN
		DELETE
		FROM
			tblUserPermission
		WHERE
			Name=@Name 
			AND 
			IsRole=@IsRole
    END
END
GO
PRINT N'Creating [dbo].[netPageTypeGetUsage]...';


GO
CREATE PROCEDURE [dbo].[netPageTypeGetUsage]
(
	@PageTypeID		INT,
	@OnlyPublished	BIT = 0
)
AS
BEGIN
	SET NOCOUNT ON
	IF (@OnlyPublished = 1)
	BEGIN
		SELECT DISTINCT
			tblPage.pkID as PageID, 
			0 AS WorkID,
			tblPageLanguage.Name,
			tblLanguageBranch.LanguageID AS LanguageBranch
		FROM 
			tblPage
		INNER JOIN 
			tblPageLanguage ON tblPage.pkID=tblPageLanguage.fkPageID
		INNER JOIN
			tblLanguageBranch ON tblLanguageBranch.pkID=tblPageLanguage.fkLanguageBranchID
		WHERE
			tblPage.fkPageTypeID = @PageTypeID
	END
	ELSE
	BEGIN
		SELECT DISTINCT
			tblPage.pkID as PageID, 
			tblWorkPage.pkID as WorkID,
			tblWorkPage.Name,
			tblLanguageBranch.LanguageID AS LanguageBranch
		FROM 
			tblWorkPage
		INNER JOIN 
			tblPage ON tblWorkPage.fkPageID = tblPage.pkID
		INNER JOIN 
			tblPageLanguage ON tblWorkPage.fkPageID=tblPageLanguage.fkPageID 
		INNER JOIN
			tblLanguageBranch ON tblLanguageBranch.pkID=tblWorkPage.fkLanguageBranchID
		WHERE
			tblPage.fkPageTypeID = @PageTypeID
	END
END
GO
PRINT N'Creating [dbo].[netPageTypeCheckUsage]...';


GO
CREATE PROCEDURE [dbo].[netPageTypeCheckUsage]
(
	@PageTypeID		INT,
	@OnlyPublished	BIT = 0
)
AS
BEGIN
	SET NOCOUNT ON
	IF (@OnlyPublished = 1)
	BEGIN
		SELECT TOP 1
			tblPage.pkID as PageID, 
			0 AS WorkID
		FROM 
			tblPage
		WHERE
			tblPage.fkPageTypeID = @PageTypeID
	END
	ELSE
	BEGIN
		SELECT TOP 1
			tblPage.pkID as PageID, 
			tblWorkPage.pkID as WorkID
		FROM 
			tblWorkPage
		INNER JOIN 
			tblPage ON tblWorkPage.fkPageID = tblPage.pkID
		WHERE
			tblPage.fkPageTypeID = @PageTypeID
	END
END
GO
PRINT N'Creating [dbo].[netPagesChangedAfter]...';


GO
CREATE PROCEDURE dbo.netPagesChangedAfter
( 
	@RootID INT,
	@ChangedAfter DATETIME,
	@MaxHits INT
)
AS
BEGIN
	SET NOCOUNT ON
    SET @MaxHits = @MaxHits + 1 -- Return one more to determine if there are more pages to fetch (gets MaxHits + 1)
    SET ROWCOUNT @MaxHits
    
	SELECT 
	    tblPageLanguage.fkPageID AS PageID,
		RTRIM(tblLanguageBranch.LanguageID) AS LanguageID
	FROM
		tblPageLanguage
	INNER JOIN
		tblTree
	ON
		tblPageLanguage.fkPageID = tblTree.fkChildID AND (tblTree.fkParentID = @RootID OR (tblTree.fkChildID = @RootID AND tblTree.NestingLevel = 1))
	INNER JOIN
		tblLanguageBranch
	ON
		tblPageLanguage.fkLanguageBranchID = tblLanguageBranch.pkID
	WHERE
		(tblPageLanguage.Changed > @ChangedAfter OR tblPageLanguage.StartPublish > @ChangedAfter) AND
		(tblPageLanguage.StopPublish is NULL OR tblPageLanguage.StopPublish > GetDate()) AND
		tblPageLanguage.PendingPublish=0
	ORDER BY
		tblTree.NestingLevel,
		tblPageLanguage.fkPageID,
		tblPageLanguage.Changed DESC
		
	SET ROWCOUNT 0
END
GO
PRINT N'Creating [dbo].[netPagePath]...';


GO
CREATE PROCEDURE  [dbo].[netPagePath]
(
	@PageID INT
)
AS
BEGIN

	SET NOCOUNT ON;

	SELECT PagePath FROM tblPage where tblPage.pkID = @PageID
END
GO
PRINT N'Creating [dbo].[netPageMaxFolderId]...';


GO
CREATE PROCEDURE dbo.netPageMaxFolderId
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @FolderID INT
	SELECT @FolderID=COALESCE(MAX(ExternalFolderID) + 1, 1) FROM tblPage
	RETURN @FolderID
END
GO
PRINT N'Creating [dbo].[netContentListPaged]...';


GO
CREATE PROCEDURE dbo.netContentListPaged
(
	@Binary VARBINARY(8000),
	@Threshold INT = 0,
	@LanguageBranchID INT
)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @ContentItems TABLE (LocalPageID INT)
	DECLARE	@Length SMALLINT
	DECLARE @Index SMALLINT
	SET @Index = 1
	SET @Length = DATALENGTH(@Binary)
	WHILE (@Index <= @Length)
	BEGIN
		INSERT INTO @ContentItems VALUES(SUBSTRING(@Binary, @Index, 4))
		SET @Index = @Index + 4
	END

	/* Get all languages for all items*/
	SELECT tblContentLanguage.fkContentID as PageLinkID, tblContent.fkContentTypeID as PageTypeID, tblContentLanguage.fkLanguageBranchID as PageLanguageBranchID 
	FROM tblContentLanguage
	INNER JOIN @ContentItems on LocalPageID=tblContentLanguage.fkContentID
	INNER JOIN tblContent ON tblContent.pkID = tblContentLanguage.fkContentID
	ORDER BY tblContentLanguage.fkContentID

	/* Get all language versions that is requested (including master) */
	SELECT
		L.Status AS PageWorkStatus,
		L.fkContentID AS PageLinkID,
		NULL AS PageLinkWorkID,
		CASE AutomaticLink
			WHEN 1 THEN
				(CASE
					WHEN L.ContentLinkGUID IS NULL THEN 0	/* EPnLinkNormal */
					WHEN L.FetchData=1 THEN 4				/* EPnLinkFetchdata */
					ELSE 1								/* EPnLinkShortcut */
				END)
			ELSE
				(CASE
					WHEN L.LinkURL=N'#' THEN 3				/* EPnLinkInactive */
					ELSE 2								/* EPnLinkExternal */
				END)
		END AS PageShortcutType,
		L.ExternalURL AS PageExternalURL,
		L.ContentLinkGUID AS PageShortcutLinkID,
		L.Name AS PageName,
		L.URLSegment AS PageURLSegment,
		L.LinkURL AS PageLinkURL,
		L.BlobUri,
		L.ThumbnailUri,
		L.Created AS PageCreated,
		L.Changed AS PageChanged,
		L.Saved AS PageSaved,
		L.StartPublish AS PageStartPublish,
		L.StopPublish AS PageStopPublish,
		CASE WHEN L.Status = 4 THEN CAST(0 AS BIT) ELSE CAST(1 AS BIT) END AS PagePendingPublish,
		L.CreatorName AS PageCreatedBy,
		L.ChangedByName AS PageChangedBy,
		L.fkFrameID AS PageTargetFrame,
		0 AS PageChangedOnPublish,
		0 AS PageDelayedPublish,
		L.fkLanguageBranchID AS PageLanguageBranchID,
		L.DelayPublishUntil AS PageDelayPublishUntil
	FROM @ContentItems AS P
	INNER JOIN tblContentLanguage AS L ON LocalPageID=L.fkContentID
	WHERE 
		L.fkLanguageBranchID = @LanguageBranchID
	OR
		L.fkLanguageBranchID = (SELECT tblContent.fkMasterLanguageBranchID FROM tblContent
			WHERE tblContent.pkID=L.fkContentID)
	ORDER BY L.fkContentID

	IF (@@ROWCOUNT = 0)
	BEGIN
		RETURN
	END
		

/* Get data for page */
	SELECT
		LocalPageID AS PageLinkID,
		NULL AS PageLinkWorkID,
		fkParentID  AS PageParentLinkID,
		fkContentTypeID AS PageTypeID,
		NULL AS PageTypeName,
		CONVERT(INT,VisibleInMenu) AS PageVisibleInMenu,
		ChildOrderRule AS PageChildOrderRule,
		0 AS PagePeerOrderRule,	-- No longer used
		PeerOrder AS PagePeerOrder,
		CONVERT(NVARCHAR(38),tblContent.ContentGUID) AS PageGUID,
		ArchiveContentGUID AS PageArchiveLinkID,
		ExternalFolderID AS PageFolderID,
		ContentAssetsID,
		ContentOwnerID,
		CONVERT(INT,Deleted) AS PageDeleted,
		DeletedBy AS PageDeletedBy,
		DeletedDate AS PageDeletedDate,
		fkMasterLanguageBranchID AS PageMasterLanguageBranchID,
		CreatorName
	FROM @ContentItems
	INNER JOIN tblContent ON LocalPageID=tblContent.pkID
	ORDER BY tblContent.pkID

	IF (@@ROWCOUNT = 0)
	BEGIN
		RETURN
	END

	
	/* Get the properties */
	/* NOTE! The CASE:s for LongString and Guid uses the precomputed LongStringLength to avoid 
	referencing LongString which may slow down the query */
	SELECT
		tblContentProperty.fkContentID AS PageLinkID,
		NULL AS PageLinkWorkID,
		tblPropertyDefinition.Name AS PropertyName,
		tblPropertyDefinition.pkID as PropertyDefinitionID,
		ScopeName,
		CONVERT(INT, Boolean) AS Boolean,
		Number AS IntNumber,
		FloatNumber,
		tblContentProperty.ContentType AS PageType,
		ContentLink AS PageLinkID,
		LinkGuid,	
		Date AS DateValue,
		String,
		(CASE 
			WHEN (@Threshold = 0) OR (COALESCE(LongStringLength, 2147483647) < @Threshold) THEN
				LongString
			ELSE
				NULL
		END) AS LongString,
		tblContentProperty.fkLanguageBranchID AS PageLanguageBranchID,
		(CASE 
			WHEN (@Threshold = 0) OR (COALESCE(LongStringLength, 2147483647) < @Threshold) THEN
				NULL
			ELSE
				guid
		END) AS Guid
	FROM @ContentItems AS P
	INNER JOIN tblContent ON tblContent.pkID=P.LocalPageID
	INNER JOIN tblContentProperty WITH (NOLOCK) ON tblContent.pkID=tblContentProperty.fkContentID --The join with tblContent ensures data integrity
	INNER JOIN tblPropertyDefinition ON tblPropertyDefinition.pkID=tblContentProperty.fkPropertyDefinitionID
	WHERE NOT tblPropertyDefinition.fkContentTypeID IS NULL AND
		(tblContentProperty.fkLanguageBranchID = @LanguageBranchID
	OR
		tblContentProperty.fkLanguageBranchID = tblContent.fkMasterLanguageBranchID)
	ORDER BY tblContent.pkID

	/*Get category information*/
	SELECT 
		fkContentID AS PageLinkID,
		NULL AS PageLinkWorkID,
		fkCategoryID,
		CategoryType
	FROM tblContentCategory
	INNER JOIN @ContentItems ON LocalPageID=tblContentCategory.fkContentID
	WHERE CategoryType=0
	ORDER BY fkContentID,fkCategoryID

	/* Get access information */
	SELECT
		fkContentID AS PageLinkID,
		NULL AS PageLinkWorkID,
		tblContentAccess.Name,
		IsRole,
		AccessMask
	FROM
		@ContentItems
	INNER JOIN 
	    tblContentAccess ON LocalPageID=tblContentAccess.fkContentID
	ORDER BY
		fkContentID
END
GO
PRINT N'Creating [dbo].[netPageListExternalFolderID]...';


GO
CREATE PROCEDURE dbo.netPageListExternalFolderID AS

	SET NOCOUNT ON
	select ExternalFolderID 
	from tblPage
GO
PRINT N'Creating [dbo].[netPageListByLanguage]...';


GO
CREATE PROCEDURE dbo.netPageListByLanguage
(
	@LanguageID nchar(17),
	@PageID INT = NULL
)
AS
BEGIN
	SET NOCOUNT ON

	IF @PageID IS NULL
	BEGIN
		SELECT tblPageLanguage.fkPageID as "PageID", tblPage.ContentType
		FROM tblPageLanguage
		INNER JOIN tblPage on tblPage.pkID = tblPageLanguage.fkPageID
		INNER JOIN tblLanguageBranch ON tblLanguageBranch.pkID=tblPageLanguage.fkLanguageBranchID
		WHERE tblLanguageBranch.LanguageID = @LanguageID
	END
	ELSE
	BEGIN
		SELECT tblPageLanguage.fkPageID as "PageID", tblPage.ContentType
		FROM tblPageLanguage
		INNER JOIN tblPage on tblPage.pkID = tblPageLanguage.fkPageID
		INNER JOIN tblTree ON tblTree.fkChildID=tblPageLanguage.fkPageID
		INNER JOIN tblLanguageBranch ON tblLanguageBranch.pkID=tblPageLanguage.fkLanguageBranchID
		WHERE tblTree.fkParentID=@PageID AND
		tblLanguageBranch.LanguageID = @LanguageID
		ORDER BY NestingLevel DESC
	END
END
GO
PRINT N'Creating [dbo].[netPageListAll]...';


GO
CREATE PROCEDURE [dbo].[netPageListAll]
(
	@PageID INT = NULL
)
AS
BEGIN
	SET NOCOUNT ON

	IF @PageID IS NULL
	BEGIN
		SELECT tblPage.pkID as "PageID", tblPage.fkParentID AS "ParentID", tblPage.ContentType
		FROM tblPage
	END
	ELSE
	BEGIN

		SELECT tblPage.pkID as "PageID", tblPage.fkParentID AS "ParentID", tblPage.ContentType
		FROM tblPage
		INNER JOIN tblTree ON tblTree.fkChildID=tblPage.pkID
		WHERE tblTree.fkParentID=@PageID
		ORDER BY NestingLevel DESC

	END
END
GO
PRINT N'Creating [dbo].[netPageLanguageSettingUpdate]...';


GO
CREATE PROCEDURE dbo.netPageLanguageSettingUpdate
(
	@PageID				INT,
	@LanguageBranch		NCHAR(17),
	@ReplacementBranch	NCHAR(17) = NULL,
	@LanguageBranchFallback NVARCHAR(1000) = NULL,
	@Active				BIT
)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @LangBranchID INT
	DECLARE @ReplacementBranchID INT

	SELECT @LangBranchID = pkID FROM tblLanguageBranch WHERE LanguageID = @LanguageBranch
	IF @LangBranchID IS NULL
	BEGIN
		RAISERROR('Language branch "%s" is not defined',16,1, @LanguageBranch)
		RETURN 0
	END

	IF NOT @ReplacementBranch IS NULL
	BEGIN
		SELECT @ReplacementBranchID = pkID FROM tblLanguageBranch WHERE LanguageID = @ReplacementBranch
		IF @ReplacementBranchID IS NULL
		BEGIN
			RAISERROR('Replacement language branch "%s" is not defined',16,1, @ReplacementBranch)
			RETURN 0
		END
	END
	
	IF EXISTS(SELECT * FROM tblPageLanguageSetting WHERE fkPageID=@PageID AND fkLanguageBranchID=@LangBranchID)
		UPDATE tblPageLanguageSetting SET
			fkReplacementBranchID	= @ReplacementBranchID,
			LanguageBranchFallback  = @LanguageBranchFallback,
			Active					= @Active
		WHERE fkPageID=@PageID AND fkLanguageBranchID=@LangBranchID

	ELSE
		INSERT INTO tblPageLanguageSetting(
				fkPageID,
				fkLanguageBranchID,
				fkReplacementBranchID,
				LanguageBranchFallback,
				Active)
		VALUES(
				@PageID, 
				@LangBranchID,
				@ReplacementBranchID,
				@LanguageBranchFallback,
				@Active
			)
		
	RETURN 0
END
GO
PRINT N'Creating [dbo].[netPageLanguageSettingListTree]...';


GO
CREATE PROCEDURE dbo.netPageLanguageSettingListTree
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
	    fkPageID,
        RTRIM(Branch.LanguageID) as LanguageBranch,
        RTRIM(ReplacementBranch.LanguageID) as ReplacementBranch,
        LanguageBranchFallback,
        Active
	FROM 
	    tblPageLanguageSetting
	INNER JOIN 
	    tblLanguageBranch AS Branch 
	ON 
	    Branch.pkID = tblPageLanguageSetting.fkLanguageBranchID
	LEFT JOIN 
	    tblLanguageBranch AS ReplacementBranch 
	ON 
	    ReplacementBranch.pkID = tblPageLanguageSetting.fkReplacementBranchID
	ORDER BY 
	    fkPageID ASC
END
GO
PRINT N'Creating [dbo].[netPageLanguageSettingList]...';


GO
CREATE PROCEDURE dbo.netPageLanguageSettingList
@PageID INT
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT	fkPageID,
			RTRIM(Branch.LanguageID) as LanguageBranch,
			RTRIM(ReplacementBranch.LanguageID) as ReplacementBranch,
			LanguageBranchFallback,
			Active
	FROM tblPageLanguageSetting
	INNER JOIN tblLanguageBranch AS Branch ON Branch.pkID = tblPageLanguageSetting.fkLanguageBranchID
	LEFT JOIN tblLanguageBranch AS ReplacementBranch ON ReplacementBranch.pkID = tblPageLanguageSetting.fkReplacementBranchID
	WHERE fkPageID=@PageID
END
GO
PRINT N'Creating [dbo].[netPageLanguageSettingDelete]...';


GO
CREATE PROCEDURE dbo.netPageLanguageSettingDelete
(
	@PageID			INT,
	@LanguageBranch	NCHAR(17)
)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @LangBranchID INT
	SELECT @LangBranchID = pkID FROM tblLanguageBranch WHERE LanguageID = @LanguageBranch
	IF @LangBranchID IS NULL
	BEGIN
		RAISERROR('Language branch %s is not defined',16,1, @LanguageBranch)
		RETURN 0
	END

	DELETE FROM tblPageLanguageSetting WHERE fkPageID=@PageID AND fkLanguageBranchID=@LangBranchID
	
END
GO
PRINT N'Creating [dbo].[netPageDynamicBlockDelete]...';


GO
CREATE PROCEDURE netPageDynamicBlockDelete
(
	@PageID INT,
	@WorkPageID INT,
	@DynamicBlock NVARCHAR(450)
)
AS
BEGIN
	SET NOCOUNT ON
	IF (@WorkPageID IS NULL OR @WorkPageID=0)
		DELETE
		FROM 
			tblProperty
		WHERE 
			fkPageID=@PageID AND ScopeName LIKE '%' + @DynamicBlock + '%'
	ELSE
		DELETE
		FROM 
			tblWorkProperty
		WHERE 
			fkWorkPageID=@WorkPageID AND ScopeName LIKE '%' + @DynamicBlock + '%'
END
GO
PRINT N'Creating [dbo].[netPageDynamicBlockList]...';


GO
CREATE PROCEDURE dbo.netPageDynamicBlockList
(
	@PageID INT,
	@WorkPageID INT
)
AS
BEGIN
	SET NOCOUNT ON
	IF (@WorkPageID IS NULL OR @WorkPageID=0)
		SELECT 
			ScopeName
		FROM 
			tblProperty
		WHERE 
			fkPageID=@PageID AND ScopeName LIKE '%.D:%'
	ELSE
		SELECT 
			ScopeName
		FROM 
			tblWorkProperty
		WHERE 
			fkWorkPageID=@WorkPageID AND ScopeName LIKE '%.D:%'
END
GO
PRINT N'Creating [dbo].[netPageDeleteLanguage]...';


GO
CREATE PROCEDURE dbo.netPageDeleteLanguage
(
	@PageID			INT,
	@LanguageBranch	NCHAR(17)
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	DECLARE @LangBranchID		INT
		
	SELECT @LangBranchID = pkID FROM tblLanguageBranch WHERE LanguageID=@LanguageBranch
	IF @LangBranchID IS NULL
	BEGIN
		RAISERROR (N'netPageDeleteLanguage: LanguageBranchID is null, possibly empty table tblLanguageBranch', 16, 1)
		RETURN 0
	END

	IF EXISTS( SELECT * FROM tblPage WHERE pkID=@PageID AND fkMasterLanguageBranchID=@LangBranchID )
	BEGIN
		RAISERROR (N'netPageDeleteLanguage: Cannot delete master language branch', 16, 1)
		RETURN 0
	END

	IF NOT EXISTS( SELECT * FROM tblPageLanguage WHERE fkPageID=@PageID AND fkLanguageBranchID=@LangBranchID )
	BEGIN
		RAISERROR (N'netPageDeleteLanguage: Language does not exist on page', 16, 1)
		RETURN 0
	END

	UPDATE tblWorkPage SET fkMasterVersionID=NULL WHERE pkID IN (SELECT pkID FROM tblWorkPage WHERE fkPageID=@PageID AND fkLanguageBranchID=@LangBranchID)
    
	DELETE FROM tblWorkProperty WHERE fkWorkPageID IN (SELECT pkID FROM tblWorkPage WHERE fkPageID=@PageID AND fkLanguageBranchID=@LangBranchID)
	DELETE FROM tblWorkCategory WHERE fkWorkPageID IN (SELECT pkID FROM tblWorkPage WHERE fkPageID=@PageID AND fkLanguageBranchID=@LangBranchID)
	DELETE FROM tblPageLanguage WHERE fkPageID=@PageID AND fkLanguageBranchID=@LangBranchID
	DELETE FROM tblWorkPage WHERE fkPageID=@PageID AND fkLanguageBranchID=@LangBranchID

	DELETE FROM tblProperty FROM tblProperty
	INNER JOIN tblPageDefinition ON tblPageDefinition.pkID=tblProperty.fkPageDefinitionID
	WHERE fkPageID=@PageID 
	AND fkLanguageBranchID=@LangBranchID
	AND fkPageTypeID IS NOT NULL
	
	DELETE FROM tblCategoryPage WHERE fkPageID=@PageID AND fkLanguageBranchID=@LangBranchID
		
	RETURN 1

END
GO
PRINT N'Creating [dbo].[netPageDefinitionWithContentType]...';


GO
CREATE PROCEDURE dbo.netPageDefinitionWithContentType
(
	@ContentTypeID	UNIQUEIDENTIFIER
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT count(*) FROM tblPageDefinition INNER JOIN 
	tblPageDefinitionType ON tblPageDefinition.fkPageDefinitionTypeID = tblPageDefinitionType.pkID
	WHERE
	fkPageTypeGUID = @ContentTypeID
END
GO
PRINT N'Creating [dbo].[netPageDefinitionTypeList]...';


GO
CREATE PROCEDURE dbo.netPageDefinitionTypeList
AS
BEGIN
	SELECT 	DT.pkID AS ID,
			DT.Name,
			DT.Property,
			DT.TypeName,
			DT.AssemblyName, 
			DT.fkPageTypeGUID AS BlockTypeID,
			PT.Name as BlockTypeName,
			PT.ModelType as BlockTypeModel
	FROM tblPageDefinitionType as DT
		LEFT OUTER JOIN tblPageType as PT ON DT.fkPageTypeGUID = PT.PageTypeGUID
	ORDER BY DT.Name
END
GO
PRINT N'Creating [dbo].[netPageDefinitionTypeDelete]...';


GO
CREATE PROCEDURE dbo.netPageDefinitionTypeDelete
(
	@ID INT
)
AS
BEGIN
	SET NOCOUNT ON

	SELECT DISTINCT pkID
	FROM tblPageDefinition 
	WHERE fkPageDefinitionTypeID=@ID

	IF (@@ROWCOUNT <> 0)
		RETURN
	
	IF @ID>=1000
		DELETE FROM tblPageDefinitionType WHERE pkID=@ID
	ELSE
		RAISERROR('Cannot delete system types',16,1)
END
GO
PRINT N'Creating [dbo].[netPageDefinitionSave]...';


GO
CREATE PROCEDURE dbo.netPageDefinitionSave
(
	@PageDefinitionID 		INT OUTPUT,
	@PageTypeID			INT,
	@Name				NVARCHAR(100),
	@PageDefinitionTypeID		INT,
	@Required			BIT = NULL,
	@Advanced			INT = NULL,
	@Searchable			BIT = NULL,
	@DefaultValueType		INT = NULL,
	@EditCaption			NVARCHAR(255) = NULL,
	@HelpText			NVARCHAR(2000) = NULL,
	@ObjectProgID			NVARCHAR(100) = NULL,
	@LongStringSettings		INT = NULL,
	@SettingsID		UNIQUEIDENTIFIER = NULL,
	@FieldOrder			INT = NULL,
	@Type 				INT = NULL OUTPUT,
	@OldType 			INT = NULL OUTPUT,
	@LanguageSpecific	INT = 0,
	@DisplayEditUI		BIT = NULL,
	@ExistsOnModel	BIT = 0
)
AS
BEGIN
	SELECT @OldType = tblPageDefinitionType.Property 
	FROM tblPageDefinition
	INNER JOIN tblPageDefinitionType ON tblPageDefinitionType.pkID=tblPageDefinition.fkPageDefinitionTypeID
	WHERE tblPageDefinition.pkID=@PageDefinitionID

	SELECT @Type = Property FROM tblPageDefinitionType WHERE pkID=@PageDefinitionTypeID
	IF @Type IS NULL
		RAISERROR('Cannot find data type',16,1)
	IF @PageTypeID=0
		SET @PageTypeID = NULL

	IF @PageDefinitionID = 0 AND @ExistsOnModel = 1
	BEGIN
		SET @PageDefinitionID = ISNULL((SELECT pkID FROM tblPageDefinition where Name = @Name AND fkPageTypeID = @PageTypeID), @PageDefinitionID)
	END

	IF @PageDefinitionID=0
	BEGIN	
		INSERT INTO tblPageDefinition
		(
			fkPageTypeID,
			fkPageDefinitionTypeID,
			Name,
			Property,
			Required,
			Advanced,
			Searchable,
			DefaultValueType,
			EditCaption,
			HelpText,
			ObjectProgID,
			LongStringSettings,
			SettingsID,
			FieldOrder,
			LanguageSpecific,
			DisplayEditUI,
			ExistsOnModel
		)
		VALUES
		(
			@PageTypeID,
			@PageDefinitionTypeID,
			@Name,
			@Type,
			@Required,
			@Advanced,
			@Searchable,
			@DefaultValueType,
			@EditCaption,
			@HelpText,
			@ObjectProgID,
			@LongStringSettings,
			@SettingsID,
			@FieldOrder,
			@LanguageSpecific,
			@DisplayEditUI,
			@ExistsOnModel
		)
		SET @PageDefinitionID =  SCOPE_IDENTITY() 
	END
	ELSE
	BEGIN
		UPDATE tblPageDefinition SET
			Name 		= @Name,
			fkPageDefinitionTypeID	= @PageDefinitionTypeID,
			Property 	= @Type,
			Required 	= @Required,
			Advanced 	= @Advanced,
			Searchable 	= @Searchable,
			DefaultValueType = @DefaultValueType,
			EditCaption 	= @EditCaption,
			HelpText 	= @HelpText,
			ObjectProgID 	= @ObjectProgID,
			LongStringSettings = @LongStringSettings,
			SettingsID = @SettingsID,
			LanguageSpecific = @LanguageSpecific,
			FieldOrder = @FieldOrder,
			DisplayEditUI = @DisplayEditUI,
			ExistsOnModel = @ExistsOnModel
		WHERE pkID=@PageDefinitionID
	END
	DELETE FROM tblPropertyDefault WHERE fkPageDefinitionID=@PageDefinitionID
	IF @LanguageSpecific<3
	BEGIN
		/* NOTE: Here we take into consideration that language neutral dynamic properties are always stored on language 
			with id 1 (which perhaps should be changed and in that case the special handling here could be removed). */
		IF @PageTypeID IS NULL
		BEGIN
			DELETE tblProperty
			FROM tblProperty
			INNER JOIN tblPage ON tblPage.pkID=tblProperty.fkPageID
			WHERE fkPageDefinitionID=@PageDefinitionID AND tblProperty.fkLanguageBranchID<>1
		END
		ELSE
		BEGIN
			DELETE tblProperty
			FROM tblProperty
			INNER JOIN tblPage ON tblPage.pkID=tblProperty.fkPageID
			WHERE fkPageDefinitionID=@PageDefinitionID AND tblProperty.fkLanguageBranchID<>tblPage.fkMasterLanguageBranchID
		END
		DELETE tblWorkProperty
		FROM tblWorkProperty
		INNER JOIN tblWorkPage ON tblWorkProperty.fkWorkPageID=tblWorkPage.pkID
		INNER JOIN tblPage ON tblPage.pkID=tblWorkPage.fkPageID
		WHERE fkPageDefinitionID=@PageDefinitionID AND tblWorkPage.fkLanguageBranchID<>tblPage.fkMasterLanguageBranchID

		DELETE 
			tblCategoryPage
		FROM
			tblCategoryPage
		INNER JOIN
			tblPage
		ON
			tblPage.pkID = tblCategoryPage.fkPageID
		WHERE
			CategoryType = @PageDefinitionID
		AND
			tblCategoryPage.fkLanguageBranchID <> tblPage.fkMasterLanguageBranchID

		DELETE 
			tblWorkCategory
		FROM
			tblWorkCategory
		INNER JOIN 
			tblWorkPage
		ON
			tblWorkCategory.fkWorkPageID = tblWorkPage.pkID
		INNER JOIN
			tblPage
		ON
			tblPage.pkID = tblWorkPage.fkPageID
		WHERE
			CategoryType = @PageDefinitionID
		AND
			tblWorkPage.fkLanguageBranchID <> tblPage.fkMasterLanguageBranchID
	END
END
GO
PRINT N'Creating [dbo].[netPageDefinitionList]...';


GO
CREATE PROCEDURE [dbo].[netPageDefinitionList]
(
	@PageTypeID INT = NULL
)
AS
BEGIN
	SELECT tblPageDefinition.pkID AS ID,
		fkPageTypeID AS PageTypeID,
		COALESCE(fkPageDefinitionTypeID,tblPageDefinition.Property) AS PageDefinitionTypeID,
		tblPageDefinition.Name,
		COALESCE(tblPageDefinitionType.Property,tblPageDefinition.Property) AS Type,
		CONVERT(INT,Required) AS Required,
		Advanced,
		CONVERT(INT,Searchable) AS Searchable,
		DefaultValueType,
		EditCaption,
		HelpText,
		ObjectProgID,
		LongStringSettings,
		SettingsID,
		CONVERT(INT,Boolean) AS Boolean,
		Number AS IntNumber,
		FloatNumber,
		PageType,
		PageLink,
		Date AS DateValue,
		String,
		LongString,
		NULL AS OldType,
		FieldOrder,
		LanguageSpecific,
		DisplayEditUI,
		ExistsOnModel
	FROM tblPageDefinition
	LEFT JOIN tblPropertyDefault ON tblPropertyDefault.fkPageDefinitionID=tblPageDefinition.pkID
	LEFT JOIN tblPageDefinitionType ON tblPageDefinitionType.pkID=tblPageDefinition.fkPageDefinitionTypeID
	WHERE (fkPageTypeID = @PageTypeID) OR (fkPageTypeID IS NULL AND @PageTypeID IS NULL)
	ORDER BY FieldOrder,tblPageDefinition.pkID
END
GO
PRINT N'Creating [dbo].[netPageDefinitionGet]...';


GO
CREATE PROCEDURE [dbo].[netPageDefinitionGet]
(
	@PageDefinitionID INT
)
AS
BEGIN
	SELECT tblPageDefinition.pkID AS ID,
		fkPageTypeID AS PageTypeID,
		COALESCE(fkPageDefinitionTypeID,tblPageDefinition.Property) AS PageDefinitionTypeID,
		tblPageDefinition.Name,
		COALESCE(tblPageDefinitionType.Property,tblPageDefinition.Property) AS Type,
		CONVERT(INT,Required) AS Required,
		Advanced,
		CONVERT(INT,Searchable) AS Searchable,
		DefaultValueType,
		EditCaption,
		HelpText,
		ObjectProgID,
		LongStringSettings,
		SettingsID,
		CONVERT(INT,Boolean) AS Boolean,
		Number AS IntNumber,
		FloatNumber,
		PageType,
		PageLink,
		Date AS DateValue,
		String,
		LongString,
		FieldOrder,
		LanguageSpecific,
		DisplayEditUI,
		ExistsOnModel
	FROM tblPageDefinition
	LEFT JOIN tblPropertyDefault ON tblPropertyDefault.fkPageDefinitionID=tblPageDefinition.pkID
	LEFT JOIN tblPageDefinitionType ON tblPageDefinitionType.pkID=tblPageDefinition.fkPageDefinitionTypeID
	WHERE tblPageDefinition.pkID = @PageDefinitionID
END
GO
PRINT N'Creating [dbo].[netPageDefinitionDynamicCheck]...';


GO
CREATE PROCEDURE dbo.netPageDefinitionDynamicCheck
(
	@PageDefinitionID	INT
)
AS
BEGIN
	SET NOCOUNT ON

	SELECT  DISTINCT
		tblProperty.fkPageID as ContentID, 
		tblLanguageBranch.Name,
		tblLanguageBranch.LanguageID AS LanguageBranch,
		tblLanguageBranch.Name AS LanguageBranchName,
		0 AS WorkID
	FROM 
		tblProperty
	INNER JOIN
		tblPage ON tblPage.pkID=tblProperty.fkPageID
	INNER JOIN
		tblLanguageBranch ON tblLanguageBranch.pkID=tblProperty.fkLanguageBranchID
	WHERE
		tblProperty.fkPageDefinitionID=@PageDefinitionID AND
		tblProperty.fkLanguageBranchID<>tblPage.fkMasterLanguageBranchID

	RETURN 0
END
GO
PRINT N'Creating [dbo].[netPageDefinitionDefault]...';


GO
CREATE PROCEDURE dbo.netPageDefinitionDefault
(
	@PageDefinitionID	INT,
	@Boolean			BIT				= NULL,
	@Number				INT				= NULL,
	@FloatNumber		FLOAT			= NULL,
	@PageType			INT				= NULL,
	@PageReference		INT				= NULL,
	@Date				DATETIME		= NULL,
	@String				NVARCHAR(450)	= NULL,
	@LongString			NVARCHAR(MAX)	= NULL
)
AS
BEGIN
	SET NOCOUNT ON
	
	DELETE FROM tblPropertyDefault WHERE fkPageDefinitionID=@PageDefinitionID
	IF (@Boolean IS NULL AND @Number IS NULL AND @FloatNumber IS NULL AND @PageType IS NULL AND 
		@PageReference IS NULL AND @Date IS NULL AND @String IS NULL AND @LongString IS NULL)
		RETURN
	
	IF (@Boolean IS NULL)
		SET @Boolean=0
		
	INSERT INTO tblPropertyDefault 
		(fkPageDefinitionID, Boolean, Number, FloatNumber, PageType, PageLink, Date, String, LongString) 
	VALUES
		(@PageDefinitionID, @Boolean, @Number, @FloatNumber, @PageType, @PageReference, @Date, @String, @LongString)
	RETURN 
END
GO
PRINT N'Creating [dbo].[netPageDefinitionConvertSave]...';


GO
CREATE PROCEDURE dbo.netPageDefinitionConvertSave
(
	@PageDefinitionID INT,
	@PageID INT = NULL,
	@WorkPageID INT = NULL,
	@LanguageBranchID INT = NULL,
	@Type INT,
	@Boolean BIT = NULL,
	@IntNumber INT = NULL,
	@FloatNumber FLOAT = NULL,
	@PageType INT = NULL,
	@LinkGuid uniqueidentifier = NULL,
	@PageReference INT = NULL,
	@DateValue DATETIME = NULL,
	@String NVARCHAR(450) = NULL,
	@LongString NVARCHAR(MAX) = NULL,
	@DeleteProperty BIT = 0
)
AS
BEGIN
	IF NOT @WorkPageID IS NULL
	BEGIN		
		IF @DeleteProperty=1 OR (@Type=0 AND @Boolean=0) OR @Type > 7
			DELETE FROM tblWorkProperty 
			WHERE fkPageDefinitionID=@PageDefinitionID AND fkWorkPageID=@WorkPageID
		ELSE
		BEGIN
			UPDATE tblWorkProperty
				SET
					Boolean=@Boolean,
					Number=@IntNumber,
					FloatNumber=@FloatNumber,
					PageType=@PageType,
					LinkGuid = @LinkGuid,
					PageLink=@PageReference,
					Date=@DateValue,
					String=@String,
					LongString=@LongString
			WHERE fkPageDefinitionID=@PageDefinitionID AND fkWorkPageID=@WorkPageID
		END
	END
	ELSE
	BEGIN
		IF @DeleteProperty=1 OR (@Type=0 AND @Boolean=0) OR @Type > 7
			DELETE FROM tblProperty 
			WHERE fkPageDefinitionID=@PageDefinitionID AND fkPageID=@PageID AND fkLanguageBranchID = @LanguageBranchID
		ELSE
		BEGIN
			UPDATE tblProperty
				SET
					Boolean=@Boolean,
					Number=@IntNumber,
					FloatNumber=@FloatNumber,
					PageType=@PageType,
					PageLink=@PageReference,
					LinkGuid = @LinkGuid,
					Date=@DateValue,
					String=@String,
					LongString=@LongString
			WHERE fkPageDefinitionID=@PageDefinitionID AND fkPageID=@PageID AND fkLanguageBranchID = @LanguageBranchID
		END
	END
END
GO
PRINT N'Creating [dbo].[netPageDefinitionConvertList]...';


GO
CREATE PROCEDURE dbo.netPageDefinitionConvertList
(
	@PageDefinitionID INT
)
AS
BEGIN

	SELECT 
			fkPageDefinitionID,
			fkPageID,
			NULL AS fkWorkPageID,
			fkLanguageBranchID,
			NULL AS fkUserPropertyID,
			ScopeName,
			CONVERT(INT,Boolean) AS Boolean,
			Number AS IntNumber,
			FloatNumber,
			PageType,
			LinkGuid,
			PageLink,
			Date AS DateValue,
			String,
			LongString,
			CONVERT(INT,0) AS DeleteProperty
	FROM tblProperty 
	WHERE fkPageDefinitionID=@PageDefinitionID

	UNION ALL
	
	SELECT 
			fkPageDefinitionID,
			NULL AS fkPageID,
			fkWorkPageID,
			NULL AS fkLanguageBranchID,
			NULL AS fkUserPropertyID,
			ScopeName,
			CONVERT(INT,Boolean) AS Boolean,
			Number AS IntNumber,
			FloatNumber,
			PageType,
			LinkGuid,
			PageLink,
			Date AS DateValue,
			String,
			LongString,
			CONVERT(INT,0) AS DeleteProperty
	FROM tblWorkProperty 
	WHERE fkPageDefinitionID=@PageDefinitionID
END
GO
PRINT N'Creating [dbo].[netContentDataLoad]...';


GO
CREATE PROCEDURE [dbo].[netContentDataLoad]
(
	@ContentID	INT, 
	@LanguageBranchID INT
)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @ContentTypeID INT
	DECLARE @MasterLanguageID INT

	SELECT @ContentTypeID = tblContent.fkContentTypeID FROM tblContent
		WHERE tblContent.pkID=@ContentID

	/*This procedure should always return a page (if exist), preferable in requested language else in master language*/
	IF (@LanguageBranchID = -1 OR NOT EXISTS (SELECT Name FROM tblContentLanguage WHERE fkContentID=@ContentID AND fkLanguageBranchID = @LanguageBranchID))
		SELECT @LanguageBranchID = fkMasterLanguageBranchID  FROM tblContent
			WHERE tblContent.pkID=@ContentID

	SELECT @MasterLanguageID = fkMasterLanguageBranchID FROM tblContent WHERE tblContent.pkID=@ContentID

	/* Get data for page */
	SELECT
		tblContent.pkID AS PageLinkID,
		NULL AS PageLinkWorkID,
		fkParentID  AS PageParentLinkID,
		fkContentTypeID AS PageTypeID,
		NULL AS PageTypeName,
		CONVERT(INT,VisibleInMenu) AS PageVisibleInMenu,
		ChildOrderRule AS PageChildOrderRule,
		PeerOrder AS PagePeerOrder,
		CONVERT(NVARCHAR(38),tblContent.ContentGUID) AS PageGUID,
		ArchiveContentGUID AS PageArchiveLinkID,
		ExternalFolderID AS PageFolderID,
		ContentAssetsID,
		ContentOwnerID,
		CONVERT(INT,Deleted) AS PageDeleted,
		DeletedBy AS PageDeletedBy,
		DeletedDate AS PageDeletedDate,
		(SELECT ChildOrderRule FROM tblContent AS ParentPage WHERE ParentPage.pkID=tblContent.fkParentID) AS PagePeerOrderRule,
		fkMasterLanguageBranchID AS PageMasterLanguageBranchID,
		CreatorName
	FROM tblContent
	WHERE tblContent.pkID=@ContentID

	IF (@@ROWCOUNT = 0)
		RETURN 0
		
	/* Get data for page languages */
	SELECT
		L.fkContentID AS PageID,
		CASE L.AutomaticLink
			WHEN 1 THEN
				(CASE
					WHEN L.ContentLinkGUID IS NULL THEN 0	/* EPnLinkNormal */
					WHEN L.FetchData=1 THEN 4				/* EPnLinkFetchdata */
					ELSE 1								/* EPnLinkShortcut */
				END)
			ELSE
				(CASE
					WHEN L.LinkURL=N'#' THEN 3				/* EPnLinkInactive */
					ELSE 2								/* EPnLinkExternal */
				END)
		END AS PageShortcutType,
		L.ExternalURL AS PageExternalURL,
		L.ContentLinkGUID AS PageShortcutLinkID,
		L.Name AS PageName,
		L.URLSegment AS PageURLSegment,
		L.LinkURL AS PageLinkURL,
		L.BlobUri,
		L.ThumbnailUri,
		L.Created AS PageCreated,
		L.Changed AS PageChanged,
		L.Saved AS PageSaved,
		L.StartPublish AS PageStartPublish,
		L.StopPublish AS PageStopPublish,
		CASE WHEN L.Status = 4 THEN CAST(0 AS BIT) ELSE CAST(1 AS BIT) END AS PagePendingPublish,
		L.CreatorName AS PageCreatedBy,
		L.ChangedByName AS PageChangedBy,
		-- RTRIM(tblContentLanguage.fkLanguageID) AS PageLanguageID,
		L.fkFrameID AS PageTargetFrame,
		0 AS PageChangedOnPublish,
		0 AS PageDelayedPublish,
		L.fkLanguageBranchID AS PageLanguageBranchID,
		L.Status as PageWorkStatus,
		L.DelayPublishUntil AS PageDelayPublishUntil
	FROM tblContentLanguage AS L
	WHERE L.fkContentID=@ContentID
		AND L.fkLanguageBranchID=@LanguageBranchID
	
	/* Get the property data for the requested language */
	SELECT
		tblPageDefinition.Name AS PropertyName,
		tblPageDefinition.pkID as PropertyDefinitionID,
		ScopeName,
		CONVERT(INT, Boolean) AS Boolean,
		Number AS IntNumber,
		FloatNumber,
		PageType,
		PageLink AS PageLinkID,
		LinkGuid,
		Date AS DateValue,
		String,
		LongString,
		tblProperty.fkLanguageBranchID AS LanguageBranchID
	FROM tblProperty
	INNER JOIN tblPageDefinition ON tblPageDefinition.pkID = tblProperty.fkPageDefinitionID
	WHERE tblProperty.fkPageID=@ContentID AND NOT tblPageDefinition.fkPageTypeID IS NULL
		AND (tblProperty.fkLanguageBranchID = @LanguageBranchID 
		OR (tblProperty.fkLanguageBranchID = @MasterLanguageID AND tblPageDefinition.LanguageSpecific < 3))

	/*Get category information*/
	SELECT fkPageID AS PageID,fkCategoryID,CategoryType
	FROM tblCategoryPage
	WHERE fkPageID=@ContentID AND CategoryType=0
	ORDER BY fkCategoryID

	/* Get access information */
	SELECT
		fkContentID AS PageID,
		Name,
		IsRole,
		AccessMask
	FROM
		tblContentAccess
	WHERE 
	    fkContentID=@ContentID
	ORDER BY
	    IsRole DESC,
		Name

	/* Get all languages for the page */
	SELECT fkLanguageBranchID as PageLanguageBranchID FROM tblContentLanguage
		WHERE tblContentLanguage.fkContentID=@ContentID
		
RETURN 0
END
GO
PRINT N'Creating [dbo].[netPageCountDescendants]...';


GO
CREATE PROCEDURE dbo.netPageCountDescendants
(
	@PageID INT = NULL
)
AS
BEGIN
	DECLARE @pageCount INT

	SET NOCOUNT ON
	IF @PageID IS NULL
	BEGIN
		SET @pageCount =
			(SELECT COUNT(*) AS PageCount
			 FROM tblPage)
	END
	ELSE
	BEGIN
		SET @pageCount =
			(SELECT COUNT(*) AS PageCount
			 FROM tblPage
			 INNER JOIN tblTree ON tblTree.fkChildID=tblPage.pkID
			 WHERE tblTree.fkParentID=@PageID)
	END

	RETURN @pageCount
END
GO
PRINT N'Creating [dbo].[netPageChangeMasterLanguage]...';


GO
CREATE PROCEDURE [dbo].[netPageChangeMasterLanguage]
(
	@PageID						INT,
	@NewMasterLanguageBranchID	INT
)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @OldMasterLanguageBranchID INT;
	DECLARE @LastNewMasterLanguageVersion INT;
	DECLARE @LastOldMasterLanguageVersion INT;
	SET @OldMasterLanguageBranchID = (SELECT fkMasterLanguageBranchID FROM tblPage WHERE pkID = @PageID);

	IF(@NewMasterLanguageBranchID = @OldMasterLanguageBranchID)
		RETURN -1;

	SET @LastNewMasterLanguageVersion = (SELECT [Version] FROM tblPageLanguage WHERE fkPageID = @PageID AND fkLanguageBranchID = @NewMasterLanguageBranchID AND PendingPublish = 0)
	IF (@LastNewMasterLanguageVersion IS NULL)
		RETURN -1;
	SET @LastOldMasterLanguageVersion = (SELECT PublishedVersion FROM tblPage WHERE pkID = @PageID)
	IF (@LastOldMasterLanguageVersion IS NULL)
		RETURN -1
	
	--Do the actual change of master language branch
	UPDATE
		tblPage
	SET
		tblPage.fkMasterLanguageBranchID = @NewMasterLanguageBranchID
	WHERE
		pkID = @PageID

	--Update tblProperty for common properties
	UPDATE
		tblProperty
	SET
		fkLanguageBranchID = @NewMasterLanguageBranchID
	FROM
		tblProperty
	INNER JOIN
		tblPageDefinition
	ON
		tblProperty.fkPageDefinitionID = tblPageDefinition.pkID
	WHERE
		LanguageSpecific < 3
	AND
		fkPageID = @PageID

	--Update tblCategoryPage for builtin and common categories
	UPDATE
		tblCategoryPage
	SET
		fkLanguageBranchID = @NewMasterLanguageBranchID
	FROM
		tblCategoryPage
	LEFT JOIN
		tblPageDefinition
	ON
		tblCategoryPage.CategoryType = tblPageDefinition.pkID
	WHERE
		(LanguageSpecific < 3
	OR
		LanguageSpecific IS NULL)
	AND
		fkPageID = @PageID

	--Move work categories and properties between the last versions of the languages
	UPDATE
		tblWorkProperty
	SET
		fkWorkPageID = @LastNewMasterLanguageVersion
	FROM
		tblWorkProperty
	INNER JOIN
		tblPageDefinition
	ON
		tblWorkProperty.fkPageDefinitionID = tblPageDefinition.pkID
	WHERE
		LanguageSpecific < 3
	AND
		fkWorkPageID = @LastOldMasterLanguageVersion

	UPDATE
		tblWorkCategory
	SET
		fkWorkPageID = @LastNewMasterLanguageVersion
	FROM
		tblWorkCategory
	LEFT JOIN
		tblPageDefinition
	ON
		tblWorkCategory.CategoryType = tblPageDefinition.pkID
	WHERE
		(LanguageSpecific < 3
	OR
		LanguageSpecific IS NULL)
	AND
		fkWorkPageID = @LastOldMasterLanguageVersion


	--Remove any remaining common properties for old master language versions
	DELETE FROM
		tblWorkProperty
	FROM
		tblWorkProperty
	INNER JOIN
		tblPageDefinition
	ON
		tblWorkProperty.fkPageDefinitionID = tblPageDefinition.pkID
	WHERE
		LanguageSpecific < 3
	AND
		fkWorkPageID IN (SELECT pkID FROM tblWorkPage WHERE fkPageID = @PageID AND fkLanguageBranchID = @OldMasterLanguageBranchID)

	--Remove any remaining common categories for old master language versions
	DELETE FROM
		tblWorkCategory
	FROM
		tblWorkCategory
	LEFT JOIN
		tblPageDefinition
	ON
		tblWorkCategory.CategoryType = tblPageDefinition.pkID
	WHERE
		(LanguageSpecific < 3
	OR
		LanguageSpecific IS NULL)
	AND
		fkWorkPageID IN (SELECT pkID FROM tblWorkPage WHERE fkPageID = @PageID AND fkLanguageBranchID = @OldMasterLanguageBranchID)

	RETURN 0
END
GO
PRINT N'Creating [dbo].[netContentListBlobUri]...';


GO
CREATE PROCEDURE [dbo].[netContentListBlobUri] 
@ContentID INT
AS
BEGIN
	SET NOCOUNT ON

	SELECT tblContentLanguage.BlobUri
	FROM tblContentLanguage
	WHERE fkContentID=@ContentID AND NOT BlobUri IS NULL
		
	SELECT tblContentLanguage.BlobUri
	FROM tblContentLanguage
	INNER JOIN tblTree ON tblTree.fkChildID=tblContentLanguage.fkContentID
	WHERE tblTree.fkParentID=@ContentID AND NOT BlobUri IS NULL		
END
GO
PRINT N'Creating [dbo].[netLanguageBranchUpdate]...';


GO
CREATE PROCEDURE dbo.netLanguageBranchUpdate
(
	@ID INT,
	@Name NVARCHAR(255) = NULL,
	@LanguageID NCHAR(17),
	@SortIndex INT,
	@SystemIconPath NVARCHAR(255) = NULL,
	@URLSegment NVARCHAR(255) = NULL,
	@Enabled BIT,
	@ACL NVARCHAR(MAX) = NULL
)
AS
BEGIN
	UPDATE
		tblLanguageBranch
	SET
		[Name] = @Name,
		LanguageID = @LanguageID,
		SortIndex = @SortIndex,
		SystemIconPath = @SystemIconPath,
		URLSegment = @URLSegment,
		Enabled = @Enabled,
		ACL = @ACL
	WHERE
		pkID = @ID
END
GO
PRINT N'Creating [dbo].[netLanguageBranchList]...';


GO
CREATE PROCEDURE dbo.netLanguageBranchList
AS
BEGIN
	SELECT 
		pkID AS ID,
		Name,
		LanguageID,
		SortIndex,
		SystemIconPath,
		URLSegment,
		Enabled,
		ACL
	FROM 
		tblLanguageBranch
	ORDER BY 
		SortIndex
END
GO
PRINT N'Creating [dbo].[netLanguageBranchInsert]...';


GO
CREATE PROCEDURE dbo.netLanguageBranchInsert
(
	@ID INT OUTPUT,
	@Name NVARCHAR(50) = NULL,
	@LanguageID NCHAR(17),
	@SortIndex INT = 0,
	@SystemIconPath NVARCHAR(255) = NULL,
	@URLSegment NVARCHAR(255) = NULL,
	@Enabled BIT,
	@ACL NVARCHAR(MAX) = NULL
)
AS
BEGIN
	INSERT INTO tblLanguageBranch
	(
		LanguageID,
		[Name],
		SortIndex,
		SystemIconPath,
		URLSegment,
		Enabled,
		ACL
	)
	VALUES
	(
		@LanguageID,
		@Name,
		@SortIndex,
		@SystemIconPath,
		@URLSegment,
		@Enabled,
		@ACL
	)
	SET @ID	=  SCOPE_IDENTITY() 
END
GO
PRINT N'Creating [dbo].[netLanguageBranchDelete]...';


GO
CREATE PROCEDURE dbo.netLanguageBranchDelete
(
	@ID INT
)
AS
BEGIN
	DELETE FROM tblLanguageBranch WHERE pkID = @ID
END
GO
PRINT N'Creating [dbo].[netFrameUpdate]...';


GO
CREATE PROCEDURE dbo.netFrameUpdate
(
	@FrameID			INT,
	@FrameName			NVARCHAR(100),
	@FrameDescription		NVARCHAR(255)
)
AS
BEGIN
	SET NOCOUNT ON

	UPDATE 
		tblFrame 
	SET 
		FrameName='target="' + @FrameName + '"', 
		FrameDescription=@FrameDescription
	WHERE
		pkID=@FrameID
		
	RETURN 0
END
GO
PRINT N'Creating [dbo].[netFrameList]...';


GO
CREATE PROCEDURE dbo.netFrameList
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		pkID AS FrameID, 
		CASE
			WHEN FrameName IS NULL THEN
				N''
			ELSE
				SUBSTRING(FrameName, 9, LEN(FrameName) - 9)
		END AS FrameName,
		FrameDescription,
		'' AS FrameDescriptionLocalized,
		CONVERT(INT, SystemFrame) AS SystemFrame
	FROM
		tblFrame
	ORDER BY
		SystemFrame DESC,
		FrameName
END
GO
PRINT N'Creating [dbo].[netFrameInsert]...';


GO
CREATE PROCEDURE dbo.netFrameInsert
(
	@FrameID		INTEGER OUTPUT,
	@FrameName		NVARCHAR(100),
	@FrameDescription	NVARCHAR(255)
)
AS
BEGIN
	SET NOCOUNT ON
	
	INSERT INTO tblFrame
		(FrameName,
		FrameDescription)
	VALUES
		('target="' + @FrameName + '"', 
		@FrameDescription)

	SET @FrameID =  SCOPE_IDENTITY() 
		
	RETURN 0
END
GO
PRINT N'Creating [dbo].[netFrameDelete]...';


GO
CREATE PROCEDURE dbo.netFrameDelete
(
	@FrameID		INT,
	@ReplaceFrameID	INT = NULL
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
		
		IF (NOT EXISTS(SELECT pkID FROM tblFrame WHERE pkID=@ReplaceFrameID))
			SET @ReplaceFrameID=NULL
		UPDATE tblWorkPage SET fkFrameID=@ReplaceFrameID WHERE fkFrameID=@FrameID
		UPDATE tblPageLanguage SET fkFrameID=@ReplaceFrameID WHERE fkFrameID=@FrameID
		DELETE FROM tblFrame WHERE pkID=@FrameID
					
	RETURN 0
END
GO
PRINT N'Creating [dbo].[netFindContentCoreDataByID]...';


GO
CREATE PROCEDURE [dbo].[netFindContentCoreDataByID]
	@ContentID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON

        --- *** use NOLOCK since this may be called during content save if debugging. The code should not be written so this happens, it's to make it work in the debugger ***
	SELECT TOP 1 P.pkID as ID, P.fkContentTypeID as ContentTypeID, P.fkParentID as ParentID, P.ContentGUID, PL.LinkURL, P.Deleted, CASE WHEN Status = 4 THEN CAST(0 AS BIT) ELSE CAST(1 AS BIT) END AS PendingPublish, PL.Created, PL.Changed, PL.Saved, PL.StartPublish, PL.StopPublish, P.ExternalFolderID, P.ContentAssetsID, P.fkMasterLanguageBranchID as MasterLanguageBranchID, PL.ContentLinkGUID as ContentLinkID, PL.AutomaticLink, PL.FetchData, P.ContentType
	FROM tblContent AS P WITH (NOLOCK)
	LEFT JOIN tblContentLanguage AS PL ON PL.fkContentID = P.pkID
	WHERE P.pkID = @ContentID AND (P.fkMasterLanguageBranchID = PL.fkLanguageBranchID OR P.fkMasterLanguageBranchID IS NULL)
END
GO
PRINT N'Creating [dbo].[netFindContentCoreDataByContentGuid]...';


GO
CREATE PROCEDURE [dbo].[netFindContentCoreDataByContentGuid]
	@ContentGuid UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON

        --- *** use NOLOCK since this may be called during page save if debugging. The code should not be written so this happens, it's to make it work in the debugger ***
	SELECT TOP 1 P.pkID as ID, P.fkContentTypeID as ContentTypeID, P.fkParentID as ParentID, P.ContentGUID, PL.LinkURL, P.Deleted, CASE WHEN Status = 4 THEN CAST(0 AS BIT) ELSE CAST(1 AS BIT) END AS PendingPublish, PL.Created, PL.Changed, PL.Saved, PL.StartPublish, PL.StopPublish, P.ExternalFolderID, P.ContentAssetsID, P.fkMasterLanguageBranchID as MasterLanguageBranchID, PL.ContentLinkGUID as ContentLinkID, PL.AutomaticLink, PL.FetchData, P.ContentType
	FROM tblContent AS P WITH (NOLOCK)
	LEFT JOIN tblContentLanguage AS PL ON PL.fkContentID=P.pkID
	WHERE P.ContentGUID = @ContentGuid AND (P.fkMasterLanguageBranchID=PL.fkLanguageBranchID OR P.fkMasterLanguageBranchID IS NULL)
END
GO
PRINT N'Creating [dbo].[netDynamicPropertyLookup]...';


GO
CREATE PROCEDURE [dbo].[netDynamicPropertyLookup]
AS
BEGIN
	SET NOCOUNT ON
	SELECT
		P.fkPageID AS PageID,
		P.fkPageDefinitionID,
		PD.Name AS PropertyName,
		LanguageSpecific,
		RTRIM(LB.LanguageID) AS BranchLanguageID,
		ScopeName,
		CONVERT(INT,Boolean) AS Boolean,
		Number AS IntNumber,
		FloatNumber,
		PageType,
		PageLink AS PageLinkID,
		LinkGuid,
		Date AS DateValue,
		String,
		LongString
	FROM
		tblProperty AS P
	INNER JOIN
		tblLanguageBranch AS LB
	ON
		P.fkLanguageBranchID = LB.pkID
	INNER JOIN
		tblPageDefinition AS PD
	ON
		PD.pkID = P.fkPageDefinitionID
	WHERE   
		(LB.Enabled = 1 OR PD.LanguageSpecific < 3) AND
		(PD.fkPageTypeID IS NULL)	
END
GO
PRINT N'Creating [dbo].[netDynamicPropertiesLoad]...';


GO
CREATE PROCEDURE [dbo].[netDynamicPropertiesLoad]
(
	@PageID INT
)
AS
BEGIN
	/* 
	Return dynamic properties for this page with edit-information
	*/
	SET NOCOUNT ON
	DECLARE @PropCount INT
	
	CREATE TABLE #tmpprop
	(
		fkPageID		INT NULL,
		fkPageDefinitionID	INT,
		fkPageDefinitionTypeID	INT,
		fkLanguageBranchID	INT NULL
	)

	/*Make sure page exists before starting*/
	IF NOT EXISTS(SELECT * FROM tblPage WHERE pkID=@PageID)
		RETURN 0

	SET @PropCount = 0

	/* Get all common dynamic properties */
	INSERT INTO #tmpprop
		(fkPageDefinitionID,
		fkPageDefinitionTypeID,
		fkLanguageBranchID)
	SELECT
		tblPageDefinition.pkID,
		fkPageDefinitionTypeID,
		1
	FROM
		tblPageDefinition
	WHERE
		fkPageTypeID IS NULL
	AND
		LanguageSpecific < 3
	/* Remember how many properties we have */
	SET @PropCount = @PropCount + @@ROWCOUNT

	/* Get all language specific dynamic properties */
	INSERT INTO #tmpprop
		(fkPageDefinitionID,
		fkPageDefinitionTypeID,
		fkLanguageBranchID)
	SELECT
		tblPageDefinition.pkID,
		fkPageDefinitionTypeID,
		tblLanguageBranch.pkID
	FROM
		tblPageDefinition
	CROSS JOIN
		tblLanguageBranch
	WHERE
		fkPageTypeID IS NULL
	AND
		LanguageSpecific > 2
	AND
		tblLanguageBranch.Enabled = 1
	ORDER BY
		tblLanguageBranch.pkID
	
	/* Remember how many properties we have */
	SET @PropCount = @PropCount + @@ROWCOUNT
	/* Get page references for all properties (if possible) */
	WHILE (@PropCount > 0 AND @PageID IS NOT NULL)
	BEGIN
	
		/* Update properties that are defined for this page */
		UPDATE #tmpprop
		SET fkPageID=@PageID
		FROM #tmpprop
		INNER JOIN tblProperty ON #tmpprop.fkPageDefinitionID=tblProperty.fkPageDefinitionID
		WHERE 				
			tblProperty.fkPageID=@PageID AND 
			#tmpprop.fkPageID IS NULL
		AND
			#tmpprop.fkLanguageBranchID = tblProperty.fkLanguageBranchID
		OR
			#tmpprop.fkLanguageBranchID IS NULL
			
		/* Remember how many properties we have left */
		SET @PropCount = @PropCount - @@ROWCOUNT
		
		/* Go up one step in the tree */
		SELECT @PageID = fkParentID FROM tblPage WHERE pkID = @PageID
	END
	
	/* Include all property rows */
	SELECT
		#tmpprop.fkPageDefinitionID,
		#tmpprop.fkPageID,
		PD.Name AS PropertyName,
		LanguageSpecific,
		RTRIM(LB.LanguageID) AS BranchLanguageID,
		ScopeName,
		CONVERT(INT,Boolean) AS Boolean,
		Number AS IntNumber,
		FloatNumber,
		PageType, 
		PageLink AS PageLinkID,
		LinkGuid,
		Date AS DateValue, 
		String, 
		LongString
	FROM
		#tmpprop
	LEFT JOIN
		tblLanguageBranch AS LB
	ON
		LB.pkID = #tmpprop.fkLanguageBranchID
	LEFT JOIN
		tblPageDefinition AS PD
	ON
		PD.pkID = #tmpprop.fkPageDefinitionID
	LEFT JOIN
		tblProperty AS P
	ON
		P.fkPageID = #tmpprop.fkPageID
	AND
		P.fkPageDefinitionID = #tmpprop.fkPageDefinitionID
	AND
		P.fkLanguageBranchID = #tmpprop.fkLanguageBranchID
	ORDER BY
		LanguageSpecific,
		#tmpprop.fkLanguageBranchID,
		FieldOrder

	DROP TABLE #tmpprop
	RETURN 0
END
GO
PRINT N'Creating [dbo].[netDelayPublishList]...';


GO
CREATE PROCEDURE dbo.netDelayPublishList
(
	@UntilDate	DATETIME,
	@ContentID		INT
)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT 
		fkContentID AS ContentID,
		pkID AS ContentWorkID,
		DelayPublishUntil
	FROM
		tblWorkContent
	WHERE
		Status = 6 AND
		DelayPublishUntil <= @UntilDate AND
		(fkContentID = @ContentID OR @ContentID IS NULL)
	ORDER BY
		DelayPublishUntil
END
GO
PRINT N'Creating [dbo].[netCreatePath]...';


GO
CREATE PROCEDURE dbo.netCreatePath
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @RootPage INT

	UPDATE tblPage SET PagePath=''
	SELECT @RootPage=pkID FROM tblPage WHERE fkParentID IS NULL AND PagePath = ''
	UPDATE tblPage SET PagePath='.' WHERE pkID=@RootPage
	
	WHILE (1 = 1)
	BEGIN
	
		UPDATE CHILD SET CHILD.PagePath = PARENT.PagePath + CONVERT(VARCHAR, PARENT.pkID) + '.'
		FROM tblPage CHILD INNER JOIN tblPage PARENT ON CHILD.fkParentID = PARENT.pkID
		WHERE CHILD.PagePath = '' AND PARENT.PagePath <> ''
		
		IF (@@ROWCOUNT = 0)
			BREAK	
	
	END	
	
END
GO
PRINT N'Creating [dbo].[netConvertPropertyForPageType]...';


GO
CREATE PROCEDURE [dbo].[netConvertPropertyForPageType]
(
	@PageID		INT,
	@FromPageType	INT,
	@FromPropertyID 	INT,
	@ToPropertyID		INT,
	@Recursive		BIT,
	@MasterLanguageID INT,
	@IsTest			BIT
)
AS
BEGIN

	DECLARE @cnt INT;
	DECLARE @LanguageSpecific INT
	DECLARE @LanguageSpecificSource INT
	DECLARE @IsBlock BIT
	SET @LanguageSpecific = 0
	SET @LanguageSpecificSource = 0
	SET @IsBlock = 0

	CREATE TABLE  #updatepages(fkChildID int)
 
	INSERT INTO #updatepages(fkChildID)  
	SELECT fkChildID 
	FROM tblTree tree
	JOIN tblPage page
	ON page.pkID = tree.fkChildID 
	WHERE @Recursive = 1
	AND tree.fkParentID = @PageID
	AND page.fkPageTypeID = @FromPageType
	UNION (SELECT pkID FROM tblPage WHERE pkID = @PageID AND fkPageTypeID = @FromPageType)

	IF @IsTest = 1
	BEGIN	
		SET @cnt = (	SELECT COUNT(*)
				FROM tblProperty 
				WHERE (fkPageDefinitionID = @FromPropertyID
				or ScopeName LIKE '%.' + CAST(@FromPropertyID as varchar) + '.%')
				AND  EXISTS (
					SELECT * from #updatepages WHERE fkChildID=fkPageID))
			+ (	SELECT COUNT(*)
				FROM tblWorkProperty 
				WHERE (fkPageDefinitionID = @FromPropertyID
				or ScopeName LIKE '%.' + CAST(@FromPropertyID as varchar) + '.%')
				AND EXISTS (
				SELECT * 
					FROM tblWorkPage 
					WHERE pkID = fkWorkPageID
					AND  EXISTS (
						SELECT * from #updatepages WHERE fkChildID=fkPageID)
				))
		IF @ToPropertyID IS NULL OR @ToPropertyID = 0-- mark deleted rows with -
			SET @cnt = -@cnt
	END
	ELSE
	BEGIN
		IF @ToPropertyID IS NULL OR @ToPropertyID = 0-- no definition exists for the new page type for this property so remove it
		BEGIN
			DELETE
			FROM tblProperty 
			WHERE (fkPageDefinitionID = @FromPropertyID
			or ScopeName LIKE '%.' + CAST(@FromPropertyID as varchar) + '.%')
			AND  EXISTS (
				SELECT * from #updatepages WHERE fkChildID=fkPageID)

			SET @cnt = -@@rowcount

			DELETE 
			FROM tblWorkProperty 
			WHERE (fkPageDefinitionID = @FromPropertyID
			or ScopeName LIKE '%.' + CAST(@FromPropertyID as varchar) + '.%')
			AND EXISTS (
				SELECT * 
				FROM tblWorkPage 
				WHERE pkID = fkWorkPageID
				AND  EXISTS (
					SELECT * from #updatepages WHERE fkChildID=fkPageID)
				)
			SET @cnt = @cnt-@@rowcount 
		END 	
		ELSE IF @FromPropertyID IS NOT NULL -- from property exists and has to be replaced
		BEGIN
			-- Need to check if the property we're converting to is unique for each language or not
			SELECT @LanguageSpecific = LanguageSpecific 
			FROM tblPageDefinition 
			WHERE pkID = @ToPropertyID

			-- Need to check if the property we're converting from is unique for each language or not
			SELECT @LanguageSpecificSource = LanguageSpecific 
			FROM tblPageDefinition 
			WHERE pkID = @FromPropertyID
			
			-- Need to check if the property we're converting is a block (Property 12 is a block)
			SELECT @IsBlock = CAST(count(*) as bit)
			FROM tblPageDefinition 
			Where pkID = @FromPropertyID and Property = 12

			IF @IsBlock = 1
			BEGIN
				DECLARE @DefinitionTypeFrom int
				DECLARE @DefinitionTypeTo int
				SET @DefinitionTypeFrom = 
					(SELECT fkPageDefinitionTypeID FROM tblPageDefinition WHERE pkID =@FromPropertyID)
				SET @DefinitionTypeTo = 
					(SELECT fkPageDefinitionTypeID FROM tblPageDefinition WHERE pkID =@ToPropertyID)
				IF (@DefinitionTypeFrom <> @DefinitionTypeTo)
				BEGIN
					RAISERROR (N'Property definitions are not of same block type.', 16, 1)
					RETURN 0
				END
				
				-- Update older versions of block
				-- update scopename in tblWorkProperty
				
				 UPDATE tblWorkProperty 
				 SET ScopeName = dbo.ConvertScopeName(ScopeName,@FromPropertyID, @ToPropertyID)
				 FROM tblWorkProperty prop
				 INNER JOIN tblWorkPage wpa ON prop.fkWorkPageID = wpa.pkID
				 WHERE ScopeName LIKE '%.' + CAST(@FromPropertyID as varchar) + '.%'
				 AND EXISTS (SELECT * from #updatepages WHERE fkChildID=wpa.fkPageID)
			
				SET @cnt = @@rowcount

				-- Update current version of block
				-- update scopename in tblProperty
				
				 UPDATE tblProperty 
				 SET ScopeName = dbo.ConvertScopeName(ScopeName,@FromPropertyID, @ToPropertyID)
				 WHERE ScopeName LIKE '%.' + CAST(@FromPropertyID as varchar) + '.%'
				 AND  EXISTS (
					SELECT * from #updatepages WHERE fkChildID=fkPageID)

				SET @cnt = @cnt + @@rowcount
			END
			ELSE -- Not a block.
			BEGIN
				-- Update older versions
				UPDATE tblWorkProperty SET fkPageDefinitionID = @ToPropertyID
					FROM tblWorkProperty prop
					INNER JOIN tblWorkPage wpa ON prop.fkWorkPageID = wpa.pkID
					WHERE prop.fkPageDefinitionID = @FromPropertyID
					AND EXISTS (SELECT * from #updatepages WHERE fkChildID=wpa.fkPageID)
			
				SET @cnt = @@rowcount

				-- Update current version 
				UPDATE tblProperty SET fkPageDefinitionID = @ToPropertyID
				WHERE fkPageDefinitionID = @FromPropertyID
				AND  EXISTS (
					SELECT * from #updatepages WHERE fkChildID=fkPageID)

				SET @cnt = @cnt + @@rowcount
			END

			IF (@LanguageSpecific < 3 AND @LanguageSpecificSource > 2)
			BEGIN
				-- The destination property is not language specific which means
				-- that we need to remove all of the old properties in other
				-- languages that could not be mapped
				DELETE FROM tblWorkProperty
					FROM tblWorkProperty prop
					INNER JOIN tblWorkPage wpa ON prop.fkWorkPageID = wpa.pkID
					WHERE (prop.fkPageDefinitionID = @ToPropertyID -- already converted to new type!
					or prop.ScopeName LIKE '%.' + CAST(@ToPropertyID as varchar) + '.%')
					AND wpa.fkLanguageBranchID <> @MasterLanguageID
					AND EXISTS (SELECT * from #updatepages WHERE fkChildID=wpa.fkPageID)
				
				SET @cnt = @cnt - @@rowcount		
				
				DELETE FROM tblProperty 
				WHERE (fkPageDefinitionID = @ToPropertyID -- already converted to new type!
				or ScopeName LIKE '%.' + CAST(@ToPropertyID as varchar) + '.%')
				AND fkLanguageBranchID <> @MasterLanguageID
				AND  EXISTS (
					SELECT * from #updatepages WHERE fkChildID=fkPageID)

				SET @cnt = @cnt - @@rowcount				
			END
			ELSE IF (@LanguageSpecificSource < 3)
			BEGIN
				-- Converting from language neutral to language supporting property
				-- We must copy existing master language property to other languages for the page
				
				-- NOTE: Due to the way language neutral properties are loaded, that is they are always
				-- loaded from published version, see netPageDataLoadVersion it is sufficient to add property
				-- values to tblProperty (no need to update tblWorkProperty
				
				INSERT INTO tblProperty
					(fkPageDefinitionID,
					fkPageID,
					fkLanguageBranchID,
					ScopeName,
					Boolean,
					Number,
					FloatNumber,
					PageType,
					PageLink,
					LinkGuid,
					Date,
					String,
					LongString,
					LongStringLength)
				SELECT 
					CASE @IsBlock when 1 then Prop.fkPageDefinitionID else @ToPropertyID end, 
					Prop.fkPageID,
					Lang.fkLanguageBranchID,
					Prop.ScopeName,
					Prop.Boolean,
					Prop.Number,
					Prop.FloatNumber,
					Prop.PageType,
					Prop.PageLink,
					Prop.LinkGuid,
					Prop.Date,
					Prop.String,
					Prop.LongString,
					Prop.LongStringLength
				FROM
				tblPageLanguage Lang
				INNER JOIN
				tblProperty Prop ON Prop.fkLanguageBranchID = @MasterLanguageID
				WHERE
				Prop.fkPageID = @PageID AND
				(Prop.fkPageDefinitionID = @ToPropertyID -- already converted to new type!
				or Prop.ScopeName LIKE '%.' + CAST(@ToPropertyID as varchar) + '.%') AND
				Prop.fkLanguageBranchID = @MasterLanguageID AND
				Lang.fkLanguageBranchID <> @MasterLanguageID AND
				Lang.fkPageID = @PageID

				-- Need to add entries to tblWorkProperty for all pages not in the master language
				-- First we need to read the master language property into a temp table
				CREATE TABLE #TempWorkProperty
				(
					fkPageDefinitionID int,
					ScopeName nvarchar(450),
					Boolean bit,
					Number int,
					FloatNumber float,
					PageType int,
					PageLink int,
				    LinkGuid uniqueidentifier,
					Date datetime,
					String nvarchar(450),
					LongString nvarchar(max)
				)

				INSERT INTO #TempWorkProperty
				SELECT
					Prop.fkPageDefinitionID,
					Prop.ScopeName,
					Prop.Boolean,
					Prop.Number,
					Prop.FloatNumber,
					Prop.PageType,
					Prop.PageLink,
				    Prop.LinkGuid,
					Prop.Date,
					Prop.String,
					Prop.LongString
				FROM
					tblWorkProperty AS Prop
					INNER JOIN
					tblWorkPage AS Page ON Prop.fkWorkPageID = Page.pkID
				WHERE
					(Prop.fkPageDefinitionID = @ToPropertyID -- already converted to new type!
				or Prop.ScopeName LIKE '%.' + CAST(@ToPropertyID as varchar) + '.%') AND
					Page.fkLanguageBranchID = @MasterLanguageID AND
					Page.fkPageID = @PageID
					ORDER BY Page.pkID DESC

				-- Now add a new property for every language (except master) using the master value
				INSERT INTO	tblWorkProperty 
				SELECT
					CASE @IsBlock when 1 then TempProp.fkPageDefinitionID else @ToPropertyID end,
					Page.pkID,
					TempProp.ScopeName,
					TempProp.Boolean,
					TempProp.Number,
					TempProp.FloatNumber,
					TempProp.PageType,
					TempProp.PageLink,
					TempProp.Date,
					TempProp.String,
					TempProp.LongString,
					TempProp.LinkGuid
				FROM 
					tblWorkPage AS Page, #TempWorkProperty AS TempProp
				WHERE
					Page.fkPageID = @PageID AND
					Page.fkLanguageBranchID <> @MasterLanguageID

				DROP TABLE #TempWorkProperty

			END
		END
	END

	DROP TABLE #updatepages

	RETURN (@cnt)
END
GO
PRINT N'Creating [dbo].[netConvertPageType]...';


GO
CREATE PROCEDURE [dbo].[netConvertPageType]
(
	@PageID		INT,
	@FromPageType	INT,
	@ToPageType		INT,
	@Recursive		BIT,
	@IsTest			BIT
)
AS
BEGIN
	DECLARE @cnt INT;

	CREATE TABLE #updatepages (fkChildID INT)

	INSERT INTO #updatepages(fkChildID)
	SELECT fkChildID
	FROM tblTree tree
	JOIN tblPage page
	ON page.pkID = tree.fkChildID 
	WHERE @Recursive = 1
	AND tree.fkParentID = @PageID
	AND page.fkPageTypeID = @FromPageType
	UNION (SELECT pkID FROM tblPage WHERE pkID = @PageID AND fkPageTypeID = @FromPageType)

	IF @IsTest = 1
	BEGIN
		SET @cnt = (SELECT COUNT(*) FROM #updatepages)
	END
	ELSE
	BEGIN		
		UPDATE tblPage SET fkPageTypeID=@ToPageType
		WHERE EXISTS (
			SELECT * from #updatepages WHERE fkChildID=pkID)
		SET @cnt = @@rowcount
	END		

	DROP TABLE #updatepages

	RETURN (@cnt)
END
GO
PRINT N'Creating [dbo].[netContentTypeToContentTypeList]...';


GO
CREATE PROCEDURE dbo.netContentTypeToContentTypeList
AS
BEGIN
	SET NOCOUNT ON
	SELECT
		fkContentTypeParentID AS ID,
		fkContentTypeChildID AS ChildID,
		Access AS AccessMask,
		Availability,
		Allow
	FROM tblContentTypeToContentType
	ORDER BY fkContentTypeParentID
END
GO
PRINT N'Creating [dbo].[netContentTypeSave]...';


GO
CREATE PROCEDURE [dbo].[netContentTypeSave]
(
	@ContentTypeID			INT					OUTPUT,
	@ContentTypeGUID		UNIQUEIDENTIFIER	OUTPUT,
	@Name				NVARCHAR(50),
	@DisplayName		NVARCHAR(50)    = NULL,
	@Description		NVARCHAR(255)	= NULL,
	@DefaultWebFormTemplate	NVARCHAR(1024)   = NULL,
	@DefaultMvcController NVARCHAR(1024)   = NULL,
	@DefaultMvcPartialView			NVARCHAR(255)   = NULL,
	@Filename			NVARCHAR(255)   = NULL,
	@Available			BIT				= NULL,
	@SortOrder			INT				= NULL,
	@ModelType			NVARCHAR(1024)	= NULL,
	
	@DefaultID			INT				= NULL,
	@DefaultName 		NVARCHAR(100)	= NULL,
	@StartPublishOffset	INT				= NULL,
	@StopPublishOffset	INT				= NULL,
	@VisibleInMenu		BIT				= NULL,
	@PeerOrder 			INT				= NULL,
	@ChildOrderRule 	INT				= NULL,
	@ArchiveContentID 		INT				= NULL,
	@FrameID 			INT				= NULL,
	@ACL				NVARCHAR(MAX)	= NULL,	
	@ContentType		INT				= 0
)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @IdString NVARCHAR(255)
	
	IF @ContentTypeID <= 0
	BEGIN
		SET @ContentTypeID = ISNULL((SELECT pkID FROM tblContentType where Name = @Name), @ContentTypeID)
	END

	IF (@ContentTypeID <= 0)
	BEGIN
		SELECT TOP 1 @IdString=IdString FROM tblContentType
		INSERT INTO tblContentType
			(Name,
			DisplayName,
			DefaultMvcController,
			DefaultWebFormTemplate,
			DefaultMvcPartialView,
			Description,
			Available,
			SortOrder,
			ModelType,
			Filename,
			IdString,
			ContentTypeGUID,
			ACL,
			ContentType)
		VALUES
			(@Name,
			@DisplayName,
			@DefaultMvcController,
			@DefaultWebFormTemplate,
			@DefaultMvcPartialView,
			@Description,
			@Available,
			@SortOrder,
			@ModelType,
			@Filename,
			@IdString,
			CASE WHEN @ContentTypeGUID IS NULL THEN NewId() ELSE @ContentTypeGUID END,
			@ACL,
			@ContentType)

		SET @ContentTypeID= SCOPE_IDENTITY() 
		
	END
	ELSE
	BEGIN
		BEGIN
			UPDATE tblContentType
			SET
				Name=@Name,
				DisplayName=@DisplayName,
				Description=@Description,
				DefaultWebFormTemplate=@DefaultWebFormTemplate,
				DefaultMvcController=@DefaultMvcController,
				DefaultMvcPartialView=@DefaultMvcPartialView,
				Available=@Available,
				SortOrder=@SortOrder,
				ModelType = @ModelType,
				Filename = @Filename,
				ACL=@ACL,
				ContentType = @ContentType
			WHERE
				pkID=@ContentTypeID
		END
	END

	SELECT @ContentTypeGUID=ContentTypeGUID FROM tblContentType WHERE pkID=@ContentTypeID
	
	IF (@DefaultID IS NULL)
	BEGIN
		DELETE FROM tblContentTypeDefault WHERE fkContentTypeID=@ContentTypeID
		RETURN 0
	END
	
	IF (EXISTS (SELECT pkID FROM tblContentTypeDefault WHERE fkContentTypeID=@ContentTypeID))
	BEGIN
		UPDATE tblContentTypeDefault SET
			Name 				= @DefaultName,
			StartPublishOffset 	= @StartPublishOffset,
			StopPublishOffset 	= @StopPublishOffset,
			VisibleInMenu 		= @VisibleInMenu,
			PeerOrder 			= @PeerOrder,
			ChildOrderRule 		= @ChildOrderRule,
			fkArchiveContentID 	= @ArchiveContentID,
			fkFrameID 			= @FrameID
		WHERE fkContentTypeID=@ContentTypeID
	END
	ELSE
	BEGIN
		INSERT INTO tblContentTypeDefault 
			(fkContentTypeID,
			Name,
			StartPublishOffset,
			StopPublishOffset,
			VisibleInMenu,
			PeerOrder,
			ChildOrderRule,
			fkArchiveContentID,
			fkFrameID)
		VALUES
			(@ContentTypeID,
			@DefaultName,
			@StartPublishOffset,
			@StopPublishOffset,
			@VisibleInMenu,
			@PeerOrder,
			@ChildOrderRule,
			@ArchiveContentID,
			@FrameID)
	END
		
	RETURN 0
END
GO
PRINT N'Creating [dbo].[netContentTypeList]...';


GO
CREATE PROCEDURE [dbo].[netContentTypeList]
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT	CT.pkID AS ID,
			CONVERT(NVARCHAR(38),CT.ContentTypeGUID) AS Guid,
			CT.Name,
			CT.DisplayName,
			CT.Description,
			CT.DefaultWebFormTemplate,
			CT.DefaultMvcController,
			CT.DefaultMvcPartialView,
			CT.Available,
			CT.SortOrder,
			CT.ModelType,
			CT.Filename,
			CT.ACL,
			CT.ContentType,
			CTD.pkID AS DefaultID,
			CTD.Name AS DefaultName,
			CTD.StartPublishOffset,
			CTD.StopPublishOffset,
			CONVERT(INT,CTD.VisibleInMenu) AS VisibleInMenu,
			CTD.PeerOrder,
			CTD.ChildOrderRule,
			CTD.fkFrameID AS FrameID,
			CTD.fkArchiveContentID AS ArchiveContentLink
	FROM tblContentType CT
	LEFT JOIN tblContentTypeDefault AS CTD ON CTD.fkContentTypeID=CT.pkID 
	ORDER BY CT.SortOrder
END
GO
PRINT N'Creating [dbo].[netContentTypeDeleteAvailable]...';


GO
CREATE PROCEDURE dbo.netContentTypeDeleteAvailable
	@ContentTypeID INT,
	@ChildID INT = 0
AS
BEGIN
	IF (@ChildID = 0)
		DELETE FROM tblContentTypeToContentType WHERE fkContentTypeParentID = @ContentTypeID
	ELSE
		DELETE FROM tblContentTypeToContentType WHERE fkContentTypeParentID = @ContentTypeID AND fkContentTypeChildID = @ChildID
END
GO
PRINT N'Creating [dbo].[netContentTypeDelete]...';


GO
CREATE PROCEDURE dbo.netContentTypeDelete
(
	@ContentTypeID		INT
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	/* Do not try to delete a type that is in use */
	SELECT pkID as ContentID, Name as ContentName
	FROM tblContent
	INNER JOIN tblContentLanguage ON tblContentLanguage.fkContentID=tblContent.pkID
	WHERE fkContentTypeID=@ContentTypeID AND tblContentLanguage.fkLanguageBranchID=tblContent.fkMasterLanguageBranchID
	IF (@@ROWCOUNT <> 0)
		RETURN 1

	/* If the content type is used in a content definition, it can't be deleted */
	DECLARE @ContentTypeGuid UNIQUEIDENTIFIER
	SET @ContentTypeGuid = (SELECT ContentType.ContentTypeGUID
	FROM tblContentType as ContentType 
	WHERE ContentType.pkID=@ContentTypeID)
	
	DECLARE @PropertyDefinitionTypeID INT
	SET @PropertyDefinitionTypeID = (SELECT pkID FROM tblPropertyDefinitionType WHERE fkContentTypeGUID = @ContentTypeGuid)
	
	SELECT ContentType.pkID AS ContentTypeID, ContentType.Name AS ContentTypeName 
	FROM tblContentType AS ContentType
	INNER JOIN tblPropertyDefinition AS PropertyDefinition ON ContentType.pkID = PropertyDefinition.fkContentTypeID
	WHERE PropertyDefinition.fkPropertyDefinitionTypeID = @PropertyDefinitionTypeID
	IF (@@ROWCOUNT <> 0)
		RETURN 1
		
	/* If the content type is in use, do not delete */
	SELECT TOP 1 Property.pkID
	FROM  
	tblContentProperty as Property WITH(INDEX(IDX_tblContentProperty_ScopeName))
	INNER JOIN dbo.GetScopedBlockProperties(@ContentTypeID) as ScopedProperties ON 
			Property.ScopeName LIKE (ScopedProperties.ScopeName + '%')
	IF (@@ROWCOUNT <> 0)
		RETURN 1
	
	DELETE FROM 
		tblContentTypeDefault
	WHERE 
		fkContentTypeID=@ContentTypeID

	DELETE FROM 
		tblWorkContentProperty
	FROM 
		tblWorkContentProperty AS WP
	INNER JOIN 
		tblPropertyDefinition AS PD ON WP.fkPropertyDefinitionID=PD.pkID 
	WHERE 
		PD.Property=3 AND 
		ContentType=@ContentTypeID

	DELETE FROM 
		tblContentProperty
	FROM 
		tblContentProperty AS P
	INNER JOIN 
		tblPropertyDefinition AS PD ON P.fkPropertyDefinitionID=PD.pkID 
	WHERE 
		PD.Property=3 AND 
		ContentType=@ContentTypeID

	DELETE FROM 
		tblContentTypeToContentType 
	WHERE 
		fkContentTypeParentID=@ContentTypeID OR 
		fkContentTypeChildID=@ContentTypeID
		
	DELETE FROM 
		tblPropertyDefinition 
	WHERE 
		fkContentTypeID=@ContentTypeID

	DELETE FROM 
		tblPropertyDefinitionType
	FROM 
		tblPropertyDefinitionType
	INNER JOIN tblContentType ON tblPropertyDefinitionType.fkContentTypeGUID = tblContentType.ContentTypeGUID
	WHERE
		tblContentType.pkID=@ContentTypeID
		
	DELETE FROM 
		tblContentType
	WHERE
		pkID=@ContentTypeID
	
	RETURN 0
END
GO
PRINT N'Creating [dbo].[netContentTypeAddAvailable]...';


GO
CREATE PROCEDURE dbo.netContentTypeAddAvailable
(
	@ContentTypeID INT,
	@ChildID INT,
	@Availability INT = 0,
	@Access INT = 2,
	@Allow BIT = NULL
)
AS
BEGIN
	IF (@Availability = 1 OR @Availability = 2)
		DELETE FROM tblContentTypeToContentType WHERE
			fkContentTypeParentID = @ContentTypeID
	ELSE
		DELETE FROM tblContentTypeToContentType WHERE
			fkContentTypeParentID = @ContentTypeID AND fkContentTypeChildID = @ChildID

	INSERT INTO tblContentTypeToContentType
	(fkContentTypeParentID, fkContentTypeChildID, Access, Availability, Allow)
	VALUES
	(@ContentTypeID, @ChildID, @Access, @Availability, @Allow)
END
GO
PRINT N'Creating [dbo].[netContentRootList]...';


GO
CREATE PROCEDURE dbo.netContentRootList
AS
BEGIN
	SET NOCOUNT ON
	SELECT 
		pkID as RootPage from tblContent WHERE ContentGUID = '43F936C9-9B23-4EA3-97B2-61C538AD07C9'
	SELECT
		pkID as WasteBasket from tblContent WHERE ContentGUID = '2F40BA47-F4FC-47AE-A244-0B909D4CF988' 
	SELECT
		pkID as GlobalAssets from tblContent WHERE ContentGUID = 'E56F85D0-E833-4E02-976A-2D11FE4D598C' 
	SELECT
		pkID as ContentAssets from tblContent WHERE ContentGUID = '99D57529-61F2-47C0-80C0-F91ECA6AF1AC'
END
GO
PRINT N'Creating [dbo].[netContentMove]...';


GO
CREATE PROCEDURE [dbo].[netContentMove]
(
	@ContentID				INT,
	@DestinationContentID	INT,
	@WastebasketID		INT,
	@Archive			INT,
	@DeletedBy			VARCHAR(255) = NULL,
	@DeletedDate		DATETIME = NULL
)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @TmpParentID		INT
	DECLARE @SourceParentID		INT
	DECLARE @TmpNestingLevel	INT
	DECLARE @Delete				BIT
	DECLARE @IsDestinationLeafNode BIT
	DECLARE @SourcePath VARCHAR(7000)
	DECLARE @TargetPath VARCHAR(7000)
 
	/* Protect from moving Content under itself */
	IF (EXISTS (SELECT NestingLevel FROM tblTree WHERE fkParentID=@ContentID AND fkChildID=@DestinationContentID) OR @DestinationContentID=@ContentID)
		RETURN -1
    
    SELECT @SourcePath=ContentPath + CONVERT(VARCHAR, @ContentID) + '.' FROM tblContent WHERE pkID=@ContentID
    SELECT @TargetPath=ContentPath + CONVERT(VARCHAR, @DestinationContentID) + '.', @IsDestinationLeafNode=IsLeafNode FROM tblContent WHERE pkID=@DestinationContentID
    
	/* Switch parent to archive Content, disable stop publish and update Saved */
	UPDATE tblContent SET
		@SourceParentID		= fkParentID,
		fkParentID			= @DestinationContentID,
		ContentPath            = @TargetPath
	WHERE pkID=@ContentID

	IF @IsDestinationLeafNode = 1
		UPDATE tblContent SET IsLeafNode = 0 WHERE pkID=@DestinationContentID
	IF NOT EXISTS(SELECT * FROM tblContent WHERE fkParentID=@SourceParentID)
		UPDATE tblContent SET IsLeafNode = 1 WHERE pkID=@SourceParentID

    IF (@Archive = 1)
	BEGIN
		UPDATE tblContentLanguage SET
			StopPublish			= NULL,
			Saved				= GetDate()
		WHERE fkContentID=@ContentID

		UPDATE tblWorkContent SET
			StopPublish			= NULL
		WHERE fkContentID = @ContentID
	END
	 
	/* Remove all references to this Content and its childs, but preserve the 
		information below itself */
	DELETE FROM 
		tblTree 
	WHERE 
		fkChildID IN (SELECT fkChildID FROM tblTree WHERE fkParentID=@ContentID UNION SELECT @ContentID) AND
		fkParentID NOT IN (SELECT fkChildID FROM tblTree WHERE fkParentID=@ContentID UNION SELECT @ContentID)
 
	/* Insert information about new Contents for all Contents where the destination is a child */
	DECLARE cur CURSOR LOCAL FAST_FORWARD FOR SELECT fkParentID, NestingLevel FROM tblTree WHERE fkChildID=@DestinationContentID
	OPEN cur
	FETCH NEXT FROM cur INTO @TmpParentID, @TmpNestingLevel
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		INSERT INTO tblTree
			(fkParentID,
			fkChildID,
			NestingLevel)
		SELECT
			@TmpParentID,
			fkChildID,
			@TmpNestingLevel + NestingLevel + 1
		FROM
			tblTree
		WHERE
			fkParentID=@ContentID
		UNION ALL
		SELECT
			@TmpParentID,
			@ContentID,
			@TmpNestingLevel + 1
	 
		FETCH NEXT FROM cur INTO @TmpParentID, @TmpNestingLevel
	END
	CLOSE cur
	DEALLOCATE cur

	/* Insert information about new Contents for destination */
	INSERT INTO tblTree
		(fkParentID,
		fkChildID,
		NestingLevel)
	SELECT
		@DestinationContentID,
		fkChildID,
		NestingLevel+1
	FROM
		tblTree
	WHERE
		fkParentID=@ContentID
	UNION
	SELECT
		@DestinationContentID,
		@ContentID,
		1
  
    /* Determine if destination is somewhere under wastebasket */
    SET @Delete=0
    IF (EXISTS (SELECT NestingLevel FROM tblTree WHERE fkParentID=@WastebasketID AND fkChildID=@ContentID))
        SET @Delete=1
    
    /* Update deleted bit of Contents */
    UPDATE tblContent  SET 
		Deleted=@Delete,
		DeletedBy = @DeletedBy,
		DeletedDate = @DeletedDate
    WHERE pkID IN (SELECT fkChildID FROM tblTree WHERE fkParentID=@ContentID) OR pkID=@ContentID
	/* Update saved date for Content */
	IF(@Delete > 0)
	BEGIN
		UPDATE tblContentLanguage  SET 
				Saved=GetDate()
   		WHERE fkContentID IN (SELECT fkChildID FROM tblTree WHERE fkParentID=@ContentID) OR fkContentID=@ContentID
	END
 
    /* Create materialized path to moved Contents */
    UPDATE tblContent
    SET ContentPath=@TargetPath + CONVERT(VARCHAR, @ContentID) + '.' + RIGHT(ContentPath, LEN(ContentPath) - LEN(@SourcePath))
    WHERE pkID IN (SELECT fkChildID FROM tblTree WHERE fkParentID = @ContentID) /* Where Content is below source */    
    
	RETURN 0
END
GO
PRINT N'Creating [dbo].[netContentMatchSegment]...';


GO
CREATE PROCEDURE [dbo].[netContentMatchSegment]
(
	@ContentID INT,
	@Segment NVARCHAR(255)
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT 
		tblContent.pkID as ContentID, 
		tblContentLanguage.fkLanguageBranchID as LanguageBranchID,
		tblContent.ContentType as ContentType
	FROM tblContentLanguage INNER JOIN tblContent
		ON tblContentLanguage.fkContentID = tblContent.pkID
	WHERE tblContent.fkParentID = @ContentID AND tblContentLanguage.URLSegment = @Segment
	
END
GO
PRINT N'Creating [dbo].[netContentLoadLongString]...';


GO
CREATE PROCEDURE dbo.netContentLoadLongString
(
	@LongStringGuid	UNIQUEIDENTIFIER
)
AS
BEGIN
	SELECT LongString FROM tblContentProperty WHERE [guid]=@LongStringGuid
	IF @@ROWCOUNT = 0
	BEGIN
		SELECT LongString FROM tblWorkContentProperty WHERE [guid]=@LongStringGuid
	END
END
GO
PRINT N'Creating [dbo].[netContentListOwnedAssetFolders]...';


GO
CREATE PROCEDURE [dbo].[netContentListOwnedAssetFolders] 
	@ContentIDs AS GuidParameterTable READONLY
AS
BEGIN
	SET NOCOUNT ON

	SELECT tblContent.pkID as ContentId
	FROM tblContent INNER JOIN @ContentIDs as ParamIds on tblContent.ContentOwnerID = ParamIds.Id		
END
GO
PRINT N'Creating [dbo].[netContentCreateLanguage]...';


GO
CREATE PROCEDURE [dbo].[netContentCreateLanguage]
(
	@ContentID			INT,
	@WorkContentID		INT,
	@UserName NVARCHAR(255),
	@MaxVersions	INT = NULL,
	@SavedDate		DATETIME = NULL,
	@LanguageBranch	NCHAR(17)
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	DECLARE @LangBranchID		INT
	DECLARE @NewVersionID		INT
	
	IF @SavedDate IS NULL
		SET @SavedDate = GetDate()
	
	SELECT @LangBranchID = pkID FROM tblLanguageBranch WHERE LanguageID=@LanguageBranch
	IF @LangBranchID IS NULL
	BEGIN
		RAISERROR (N'netContentCreateLanguage: LanguageBranchID is null, possibly empty table tblLanguageBranch', 16, 1, @WorkContentID)
		RETURN 0
	END

	IF NOT EXISTS( SELECT * FROM tblContentLanguage WHERE fkContentID=@ContentID )
		UPDATE tblContent SET fkMasterLanguageBranchID=@LangBranchID WHERE pkID=@ContentID
	
	INSERT INTO tblContentLanguage(fkContentID, CreatorName, ChangedByName, Status, fkLanguageBranchID)
	SELECT @ContentID, @UserName, @UserName, 2, @LangBranchID
	FROM tblContent
	INNER JOIN tblContentType ON tblContentType.pkID=tblContent.fkContentTypeID
	WHERE tblContent.pkID=@ContentID
			
	INSERT INTO tblWorkContent
		(fkContentID,
		ChangedByName,
		ContentLinkGUID,
		fkFrameID,
		ArchiveContentGUID,
		Name,
		LinkURL,
		ExternalURL,
		VisibleInMenu,
		LinkType,
		Created,
		Saved,
		StartPublish,
		StopPublish,
		ChildOrderRule,
		PeerOrder,
		fkLanguageBranchID,
		CommonDraft)
	SELECT 
		@ContentID,
		COALESCE(@UserName, tblContentLanguage.CreatorName),
		tblContentLanguage.ContentLinkGUID,
		tblContentLanguage.fkFrameID,
		tblContent.ArchiveContentGUID,
		tblContentLanguage.Name,
		tblContentLanguage.LinkURL,
		tblContentLanguage.ExternalURL,
		tblContent.VisibleInMenu,
		CASE tblContentLanguage.AutomaticLink 
			WHEN 1 THEN 
				(CASE
					WHEN tblContentLanguage.ContentLinkGUID IS NULL THEN 0	/* EPnLinkNormal */
					WHEN tblContentLanguage.FetchData=1 THEN 4				/* EPnLinkFetchdata */
					ELSE 1												/* EPnLinkShortcut */
				END)
			ELSE
				(CASE 
					WHEN tblContentLanguage.LinkURL=N'#' THEN 3			/* EPnLinkInactive */
					ELSE 2												/* EPnLinkExternal */
				END)
		END AS LinkType ,
		tblContentLanguage.Created,
		@SavedDate,
		tblContentLanguage.StartPublish,
		tblContentLanguage.StopPublish,
		tblContent.ChildOrderRule,
		tblContent.PeerOrder,
		@LangBranchID,
		1
	FROM tblContentLanguage
	INNER JOIN tblContent ON tblContent.pkID=tblContentLanguage.fkContentID
	WHERE 
		tblContentLanguage.fkContentID=@ContentID AND tblContentLanguage.fkLanguageBranchID=@LangBranchID
		
	SET @NewVersionID = SCOPE_IDENTITY()	
	
	UPDATE tblContentLanguage SET Version = @NewVersionID
	WHERE fkContentID = @ContentID AND fkLanguageBranchID = @LangBranchID
		
	RETURN  @NewVersionID 

END
GO
PRINT N'Creating [dbo].[netContentCreate]...';


GO
CREATE PROCEDURE [dbo].[netContentCreate]
(
	@UserName NVARCHAR(255),
	@ParentID			INT,
	@ContentTypeID		INT,
	@FolderID			INT,
	@ContentGUID		UNIQUEIDENTIFIER,
	@ContentType		INT,
	@WastebasketID		INT, 
	@ContentAssetsID	UNIQUEIDENTIFIER = NULL,
	@ContentOwnerID		UNIQUEIDENTIFIER = NULL
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	DECLARE @ContentID INT
	DECLARE @Delete		BIT
	
	/* Create materialized path to content */
	DECLARE @Path VARCHAR(7000)
	DECLARE @IsParentLeafNode BIT
	SELECT @Path = ContentPath + CONVERT(VARCHAR, @ParentID) + '.', @IsParentLeafNode = IsLeafNode FROM tblContent WHERE pkID=@ParentID
	IF @IsParentLeafNode = 1
		UPDATE tblContent SET IsLeafNode = 0 WHERE pkID=@ParentID

    
    SET @Delete = 0
    IF(@WastebasketID = @ParentID)
		SET @Delete=1
    ELSE IF (EXISTS (SELECT NestingLevel FROM tblTree WHERE fkParentID=@WastebasketID AND fkChildID=@ParentID))
        SET @Delete=1
    
	/* Create new content */
	INSERT INTO tblContent 
		(fkContentTypeID, CreatorName, fkParentID, ExternalFolderID, ContentAssetsID, ContentOwnerID, ContentGUID, ContentPath, ContentType, Deleted)
	VALUES
		(@ContentTypeID, @UserName, @ParentID, @FolderID, @ContentAssetsID, @ContentOwnerID, @ContentGUID, @Path, @ContentType, @Delete)

	/* Remember pkID of content */
	SET @ContentID= SCOPE_IDENTITY() 
	 
	/* Update content tree with info about this content */
	INSERT INTO tblTree
		(fkParentID, fkChildID, NestingLevel)
	SELECT 
		fkParentID,
		@ContentID,
		NestingLevel+1
	FROM tblTree
	WHERE fkChildID=@ParentID
	UNION ALL
	SELECT
		@ParentID,
		@ContentID,
		1
	  

	RETURN @ContentID
END
GO
PRINT N'Creating [dbo].[netContentChildrenReferences]...';


GO
CREATE PROCEDURE [dbo].[netContentChildrenReferences]
(
	@ParentID INT,
	@LanguageID NCHAR(17),
	@ChildOrderRule INT OUTPUT
)
AS
BEGIN
	SET NOCOUNT ON
/*	
		/// <summary>
		/// Most recently created page will be first in list
		/// </summary>
		CreatedDescending		= 1,
		/// <summary>
		/// Oldest created page will be first in list
		/// </summary>
		CreatedAscending		= 2,
		/// <summary>
		/// Sorted alphabetical on name
		/// </summary>
		Alphabetical			= 3,
		/// <summary>
		/// Sorted on page index
		/// </summary>
		Index					= 4,
		/// <summary>
		/// Most recently changed page will be first in list
		/// </summary>
		ChangedDescending		= 5,
		/// <summary>
		/// Sort on ranking, only supported by special controls
		/// </summary>
		Rank					= 6,
		/// <summary>
		/// Oldest published page will be first in list
		/// </summary>
		PublishedAscending		= 7,
		/// <summary>
		/// Most recently published page will be first in list
		/// </summary>
		PublishedDescending		= 8
*/
	SELECT @ChildOrderRule = ChildOrderRule FROM tblContent WHERE pkID=@ParentID
		
	IF (@ChildOrderRule = 1)
	BEGIN
		SELECT
			pkID AS ContentLinkID, ContentType, fkContentTypeID as ContentTypeID, IsLeafNode
		FROM 
			tblContent
		INNER JOIN
			tblContentLanguage ON tblContentLanguage.fkContentID=tblContent.pkID
		WHERE 
			fkParentID=@ParentID AND tblContent.fkMasterLanguageBranchID=tblContentLanguage.fkLanguageBranchID
		ORDER BY 
			Created DESC,ContentLinkID DESC

		RETURN @@ROWCOUNT
	END

	IF (@ChildOrderRule = 2)
	BEGIN
		SELECT
			pkID AS ContentLinkID, ContentType, fkContentTypeID as ContentTypeID, IsLeafNode
		FROM 
			tblContent
		INNER JOIN
			tblContentLanguage ON tblContentLanguage.fkContentID=tblContent.pkID
		WHERE 
			fkParentID=@ParentID AND tblContent.fkMasterLanguageBranchID=tblContentLanguage.fkLanguageBranchID
		ORDER BY 
			Created ASC,ContentLinkID ASC

		RETURN @@ROWCOUNT
	END

	IF (@ChildOrderRule = 3)
	BEGIN
		-- Get language branch for listing since we want to sort on name
		DECLARE @LanguageBranchID INT
		SELECT 
			@LanguageBranchID = pkID 
		FROM 
			tblLanguageBranch 
		WHERE 
			LOWER(LanguageID)=LOWER(@LanguageID)

		-- If we did not find a valid language branch, go with master language branch from tblContent
		IF (@@ROWCOUNT < 1)
		BEGIN
			SELECT
			pkID AS ContentLinkID, ContentType, fkContentTypeID as ContentTypeID, IsLeafNode
			FROM 
				tblContent
			INNER JOIN
				tblContentLanguage ON tblContentLanguage.fkContentID=tblContent.pkID
			WHERE 
				fkParentID=@ParentID AND tblContent.fkMasterLanguageBranchID=tblContentLanguage.fkLanguageBranchID
			ORDER BY 
				Name ASC

		    RETURN @@ROWCOUNT
		END

		SELECT
			pkID AS ContentLinkID, ContentType, fkContentTypeID as ContentTypeID, IsLeafNode
		FROM 
			tblContent AS P
		LEFT JOIN
			tblContentLanguage AS PL ON PL.fkContentID=P.pkID AND 
			PL.fkLanguageBranchID=@LanguageBranchID
		WHERE 
			P.fkParentID=@ParentID
		ORDER BY 
			PL.Name ASC

		RETURN @@ROWCOUNT
	END

	IF (@ChildOrderRule = 4)
	BEGIN
		SELECT
			pkID AS ContentLinkID, ContentType, fkContentTypeID as ContentTypeID, IsLeafNode
		FROM 
			tblContent
		WHERE 
			fkParentID=@ParentID
		ORDER BY 
			PeerOrder ASC

		RETURN @@ROWCOUNT
	END

	IF (@ChildOrderRule = 5)
	BEGIN
		SELECT
			pkID AS ContentLinkID, ContentType, fkContentTypeID as ContentTypeID, IsLeafNode
		FROM 
			tblContent
		INNER JOIN
			tblContentLanguage ON tblContentLanguage.fkContentID=tblContent.pkID
		WHERE 
			fkParentID=@ParentID AND tblContent.fkMasterLanguageBranchID=tblContentLanguage.fkLanguageBranchID
		ORDER BY 
			Changed DESC

		RETURN @@ROWCOUNT
	END

	IF (@ChildOrderRule = 7)
	BEGIN
		SELECT
			pkID AS ContentLinkID, ContentType, fkContentTypeID as ContentTypeID, IsLeafNode
		FROM 
			tblContent
		INNER JOIN
			tblContentLanguage ON tblContentLanguage.fkContentID=tblContent.pkID
		WHERE 
			fkParentID=@ParentID AND tblContent.fkMasterLanguageBranchID=tblContentLanguage.fkLanguageBranchID
		ORDER BY 
			StartPublish ASC

		RETURN @@ROWCOUNT
	END

	IF (@ChildOrderRule = 8)
	BEGIN
		SELECT
			pkID AS ContentLinkID, ContentType, fkContentTypeID as ContentTypeID, IsLeafNode
		FROM 
			tblContent
		INNER JOIN
			tblContentLanguage ON tblContentLanguage.fkContentID=tblContent.pkID
		WHERE 
			fkParentID=@ParentID AND tblContent.fkMasterLanguageBranchID=tblContentLanguage.fkLanguageBranchID
		ORDER BY 
			StartPublish DESC

		RETURN @@ROWCOUNT
	END

END
GO
PRINT N'Creating [dbo].[netContentAclSetInherited]...';


GO
CREATE PROCEDURE dbo.netContentAclSetInherited
(
	@ContentID INT,
	@Recursive INT
)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@Recursive = 1)
    BEGIN
        /* Remove all old ACEs for @ContentID and below */
        DELETE FROM 
           tblContentAccess
        WHERE 
            fkContentID IN (SELECT fkChildID FROM tblTree WHERE fkParentID=@ContentID) OR 
            fkContentID=@ContentID
        RETURN
    END
	ELSE
	BEGIN
		DELETE FROM tblContentAccess
		WHERE fkContentID = @ContentID
	END
END
GO
PRINT N'Creating [dbo].[netContentAclList]...';


GO
CREATE PROCEDURE dbo.netContentAclList
(
	@ContentID INT
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT 
		Name,
		IsRole, 
		AccessMask
	FROM 
		tblContentAccess
	WHERE 
		fkContentID=@ContentID
	ORDER BY
		IsRole DESC,
		Name
END
GO
PRINT N'Creating [dbo].[netContentAclDeleteEntity]...';


GO
CREATE PROCEDURE dbo.netContentAclDeleteEntity
(
	@Name NVARCHAR(255),
	@IsRole INT
)
AS
BEGIN
	SET NOCOUNT ON
	
	DELETE FROM tblContentAccess WHERE Name=@Name AND IsRole=@IsRole
END
GO
PRINT N'Creating [dbo].[netContentAclDelete]...';


GO
CREATE PROCEDURE dbo.netContentAclDelete
(
	@Name NVARCHAR(255),
	@IsRole INT,
	@ContentID INT
)
AS
BEGIN
	SET NOCOUNT ON
	
	DELETE FROM tblContentAccess WHERE fkContentID=@ContentID AND Name=@Name AND IsRole=@IsRole
END
GO
PRINT N'Creating [dbo].[netContentAclChildDelete]...';


GO
CREATE PROCEDURE dbo.netContentAclChildDelete
(
	@Name NVARCHAR(255),
	@IsRole INT,
	@ContentID	INT
)
AS
BEGIN
    SET NOCOUNT ON
 
    IF (@Name IS NULL)
    BEGIN
        DELETE FROM 
           tblContentAccess
        WHERE EXISTS(SELECT * FROM tblTree WHERE fkParentID=@ContentID AND fkChildID=tblContentAccess.fkContentID)
            
        RETURN
    END

    DELETE FROM 
       tblContentAccess
    WHERE Name=@Name
		AND IsRole=@IsRole
		AND EXISTS(SELECT * FROM tblTree WHERE fkParentID=@ContentID AND fkChildID=tblContentAccess.fkContentID)
END
GO
PRINT N'Creating [dbo].[netContentAclChildAdd]...';


GO
CREATE PROCEDURE dbo.netContentAclChildAdd
(
	@Name NVARCHAR(255),
	@IsRole INT,
	@ContentID	INT,
	@AccessMask INT,
	@Merge BIT = 0
)
AS
BEGIN
    SET NOCOUNT ON

	CREATE TABLE #ignorecontents(IgnoreContentID INT PRIMARY KEY)

	IF @Merge = 1
	BEGIN
		INSERT INTO #ignorecontents(IgnoreContentID)
		SELECT fkChildID
		FROM tblTree
		WHERE fkParentID=@ContentID AND NOT EXISTS(SELECT * FROM tblContentAccess WHERE fkContentID=tblTree.fkChildID)

		EXEC netContentAclChildDelete @Name=@Name, @IsRole=@IsRole, @ContentID=@ContentID
	END
        
    /* Create new ACEs for all childs to @ContentID */
	INSERT INTO tblContentAccess 
		(fkContentID, 
		Name,
		IsRole, 
		AccessMask) 
	SELECT 
		fkChildID, 
		@Name,
		@IsRole, 
		@AccessMask
	FROM 
		tblTree
	WHERE 
		fkParentID=@ContentID AND NOT EXISTS(SELECT * FROM #ignorecontents WHERE IgnoreContentID=tblTree.fkChildID)
        
END
GO
PRINT N'Creating [dbo].[netContentAclAdd]...';


GO
CREATE PROCEDURE dbo.netContentAclAdd
(
	@Name NVARCHAR(255),
	@IsRole INT,
	@ContentID INT,
	@AccessMask INT
)
AS
BEGIN
	SET NOCOUNT ON
	
	UPDATE 
	    tblContentAccess 
	SET 
	    AccessMask=@AccessMask
	WHERE 
	    fkContentID=@ContentID AND 
	    Name=@Name AND 
	    IsRole=@IsRole
	    
	IF (@@ROWCOUNT = 0)
	BEGIN
		-- Does not exist, create it
		INSERT INTO tblContentAccess 
		    (fkContentID, Name, IsRole, AccessMask) 
		VALUES 
		    (@ContentID, @Name, @IsRole, @AccessMask)
	END
END
GO
PRINT N'Creating [dbo].[netChangeLogTruncBySeqNDate]...';


GO
CREATE PROCEDURE [dbo].[netChangeLogTruncBySeqNDate]
(
	@LowestSequenceNumber BIGINT = NULL,
	@OlderThan DATETIME = NULL
)
AS
BEGIN	
	
	DELETE FROM tblChangeLog WHERE
	((@LowestSequenceNumber IS NULL) OR (pkID < @LowestSequenceNumber)) AND
	((@OlderThan IS NULL) OR (ChangeDate < @OlderThan))
	
END
GO
PRINT N'Creating [dbo].[netChangeLogTruncByRowsNDate]...';


GO
CREATE PROCEDURE [dbo].[netChangeLogTruncByRowsNDate]
(
	@RowsToTruncate BIGINT = NULL,
	@OlderThan DATETIME = NULL
)
AS
BEGIN	

	IF (@RowsToTruncate IS NOT NULL)
	BEGIN
		DELETE TOP(@RowsToTruncate) FROM tblChangeLog WHERE
		((@OlderThan IS NULL) OR (ChangeDate < @OlderThan))
		RETURN		
	END
	
	DELETE FROM tblChangeLog WHERE
	((@OlderThan IS NULL) OR (ChangeDate < @OlderThan))
	
END
GO
PRINT N'Creating [dbo].[netChangeLogSave]...';


GO
CREATE PROCEDURE [dbo].[netChangeLogSave]
  (@LogData          [nvarchar](max),
   @Category         INTEGER = 0,
   @Action			 INTEGER = 0,
   @ChangedBy        [nvarchar](255),
   @SequenceNumber   BIGINT OUTPUT,
   @ChangeDate       DATETIME OUTPUT
)


AS            
BEGIN
	SET @ChangeDate = getutcdate()

       INSERT INTO tblChangeLog VALUES(@LogData,
                                       @ChangeDate,
                                       @Category,
                                       @Action,
                                       @ChangedBy)

	SET @SequenceNumber = SCOPE_IDENTITY()
END
GO
PRINT N'Creating [dbo].[netChangeLogGetRowsForwards]...';


GO
CREATE PROCEDURE [dbo].[netChangeLogGetRowsForwards]
(
	@from 	                 DATETIME = NULL,
	@to	                     DATETIME = NULL,
	@category 				 INT = NULL,
	@action 				 INT = NULL,
	@changedBy				 [nvarchar](255) = NULL,
	@startSequence			 BIGINT = NULL,
	@maxRows				 BIGINT)
AS
BEGIN    
        SELECT top(@maxRows) *
        FROM tblChangeLog TCL
        WHERE 
        ((@startSequence IS NULL) OR (TCL.pkID >= @startSequence)) AND
		((@from IS NULL) OR (TCL.ChangeDate >= @from)) AND
		((@to IS NULL) OR (TCL.ChangeDate <= @to)) AND  
        ((@category IS NULL) OR (@category = TCL.Category)) AND
        ((@action IS NULL) OR (@action = TCL.Action)) AND
        ((@changedBy IS NULL) OR (@changedBy = TCL.ChangedBy))
        
		ORDER BY TCL.pkID ASC
END
GO
PRINT N'Creating [dbo].[netChangeLogGetRowsBackwards]...';


GO
CREATE PROCEDURE [dbo].[netChangeLogGetRowsBackwards]
(
	@from 	                 DATETIME = NULL,
	@to	                     DATETIME = NULL,
	@category 				 INT = NULL,
	@action 				 INT = NULL,
	@changedBy				 [nvarchar](255) = NULL,
	@startSequence			 BIGINT = NULL,
	@maxRows				 BIGINT)
AS
BEGIN    
        SELECT top(@maxRows) *
        FROM tblChangeLog TCL
        WHERE 
        ((@startSequence IS NULL) OR (TCL.pkID <= @startSequence)) AND
		((@from IS NULL) OR (TCL.ChangeDate >= @from)) AND
		((@to IS NULL) OR (TCL.ChangeDate <= @to)) AND  
        ((@category IS NULL) OR (@category = TCL.Category)) AND
        ((@action IS NULL) OR (@action = TCL.Action)) AND
        ((@changedBy IS NULL) OR (@changedBy = TCL.ChangedBy))
        
		ORDER BY TCL.pkID DESC
END
GO
PRINT N'Creating [dbo].[netChangeLogGetHighestSeqNum]...';


GO
CREATE PROCEDURE [dbo].[netChangeLogGetHighestSeqNum]
(
	@count BIGINT = 0 OUTPUT
)
AS
BEGIN
	select @count = MAX(pkID) from tblChangeLog
END
SET QUOTED_IDENTIFIER ON
GO
PRINT N'Creating [dbo].[netChangeLogGetCountBackwards]...';


GO
CREATE PROCEDURE [dbo].[netChangeLogGetCountBackwards]
(
	@from 	                 DATETIME = NULL,
	@to	                     DATETIME = NULL,
	@category 				 INT = 0,
	@action 				 INT = 0,
	@changedBy				 [nvarchar](255) = NULL,
	@startSequence			 BIGINT = 0,
	@count                   BIGINT = 0 OUTPUT)
AS
BEGIN    
        SELECT @count = count(*)
        FROM tblChangeLog TCL
        WHERE 
        (TCL.pkID <= @startSequence) AND
		((@from IS NULL) OR (TCL.ChangeDate >= @from)) AND
		((@to IS NULL) OR (TCL.ChangeDate <= @to)) AND  
        ((@category = 0) OR (@category = TCL.Category)) AND
        ((@action = 0) OR (@action = TCL.Action)) AND
        ((@changedBy IS NULL) OR (@changedBy = TCL.ChangedBy))
		
END
GO
PRINT N'Creating [dbo].[netChangeLogGetCount]...';


GO
CREATE PROCEDURE [dbo].[netChangeLogGetCount]
(
	@from 	                 DATETIME = NULL,
	@to	                     DATETIME = NULL,
	@category 				 INT = 0,
	@action 				 INT = 0,
	@changedBy				 [nvarchar](255) = NULL,
	@startSequence			 BIGINT = 0,
	@count                   BIGINT = 0 OUTPUT)
AS
BEGIN    
        SELECT @count = count(*)
        FROM tblChangeLog TCL
        WHERE 
        ((@startSequence = 0) OR (TCL.pkID >= @startSequence)) AND
		((@from IS NULL) OR (TCL.ChangeDate >= @from)) AND
		((@to IS NULL) OR (TCL.ChangeDate <= @to)) AND  
        ((@category = 0) OR (@category = TCL.Category)) AND
        ((@action = 0) OR (@action = TCL.Action)) AND
        ((@changedBy IS NULL) OR (@changedBy = TCL.ChangedBy))
		
END
GO
PRINT N'Creating [dbo].[netCategoryStringToTable]...';


GO
CREATE PROCEDURE dbo.netCategoryStringToTable
(
	@CategoryList	NVARCHAR(2000)
)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE		@DotPos INT
	DECLARE		@Category NVARCHAR(255)
	
	WHILE (DATALENGTH(@CategoryList) > 0)
	BEGIN
		SET @DotPos = CHARINDEX(N',', @CategoryList)
		IF @DotPos > 0
			SET @Category = LEFT(@CategoryList,@DotPos-1)
		ELSE
		BEGIN
			SET @Category = @CategoryList
			SET @CategoryList = NULL
		END
		BEGIN TRY
		    INSERT INTO #category SELECT pkID FROM tblCategory WHERE pkID = CAST(@Category AS INT)
		END TRY
		BEGIN CATCH
		     INSERT INTO #category SELECT pkID FROM tblCategory WHERE CategoryName = @Category
		END CATCH
			
		IF (DATALENGTH(@CategoryList) > 0)
			SET @CategoryList = SUBSTRING(@CategoryList,@DotPos+1,255)
	END
	RETURN 0
END
GO
PRINT N'Creating [dbo].[netCategorySave]...';


GO
CREATE PROCEDURE dbo.netCategorySave
(
	@CategoryID		INT OUTPUT,
	@CategoryName	NVARCHAR(50),
	@Description	NVARCHAR(255),
	@Values			INT,
	@SortOrder		INT,
	@ParentID		INT = NULL,
	@Guid			UNIQUEIDENTIFIER = NULL
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	IF (@CategoryID IS NULL)
	BEGIN
			SELECT @SortOrder=Max(SortOrder) + 10 FROM tblCategory 
			IF (@SortOrder IS NULL)
				SET @SortOrder=100
				
			INSERT INTO tblCategory 
				(CategoryName, 
				CategoryDescription, 
				fkParentID, 
				Available, 
				Selectable,
				SortOrder,
				CategoryGUID) 
			VALUES 
				(@CategoryName,
				@Description,
				@ParentID,
				case when (@Values & 1) = 1 then 1 else 0 end,

				case when (@Values & 2) = 2 then 1 else 0 end,
				@SortOrder,
				COALESCE(@Guid,NewId()))
		SET @CategoryID =  SCOPE_IDENTITY() 
	END
	ELSE
	BEGIN
		UPDATE 
			tblCategory 
		SET 
			CategoryName		= @CategoryName,
			CategoryDescription	= @Description,
			SortOrder		= @SortOrder,
			Available			= case when (@Values & 1) = 1 then 1 else 0 end,
			Selectable			= case when (@Values & 2) = 2 then 1 else 0 end,
			CategoryGUID		= COALESCE(@Guid,CategoryGUID)
		WHERE 
			pkID=@CategoryID
	END
	
	RETURN 0
END
GO
PRINT N'Creating [dbo].[netCategoryListAll]...';


GO
CREATE PROCEDURE dbo.netCategoryListAll
(
	@CompactList	INT = 0
)
AS
BEGIN
	SET NOCOUNT ON

	IF @CompactList = 1 
		SELECT
			pkID AS CategoryID,
			CategoryName
		FROM
			tblCategory
		WHERE 
			pkID <> 1
		ORDER BY
			SortOrder
	ELSE	
		SELECT
			pkID AS CategoryID,
			fkParentID AS ParentID,
			(SELECT COUNT(TC.pkID) FROM tblCategory AS TC WHERE TC.fkParentID=tblCategory.pkID) AS ChildCount,
			CategoryName,
			CategoryDescription,
			Available + Selectable * 2 AS CategoryValue,
			SortOrder,
			CONVERT(NVARCHAR(38), CategoryGUID) AS CategoryGUID
		FROM
			tblCategory
		WHERE 
			pkID <> 1
		ORDER BY
			SortOrder
	
	RETURN 0
END
GO
PRINT N'Creating [dbo].[netCategoryDelete]...';


GO
CREATE PROCEDURE dbo.netCategoryDelete
(
	@CategoryID			INT
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
		
		/* Delete any references */
		DELETE FROM tblCategoryPage WHERE fkCategoryID=@CategoryID
		DELETE FROM tblWorkCategory WHERE fkCategoryID=@CategoryID
		/* Delete the category */
		DELETE FROM tblCategory WHERE pkID=@CategoryID

	RETURN 0
END
GO
PRINT N'Creating [dbo].[netCategoryContentLoad]...';


GO
CREATE PROCEDURE [dbo].[netCategoryContentLoad]
(
	@ContentID			INT,
	@VersionID		INT,
	@CategoryType	INT,
	@LanguageBranch	NCHAR(17) = NULL,
	@ScopeName NVARCHAR(450)
)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @LangBranchID NCHAR(17);
	DECLARE @LanguageSpecific INT;

	IF(@VersionID = 0)
			SET @VersionID = NULL;
	IF @VersionID IS NOT NULL AND @LanguageBranch IS NOT NULL
	BEGIN
		IF NOT EXISTS(	SELECT
							LanguageID
						FROM
							tblWorkContent 
						INNER JOIN
							tblLanguageBranch
						ON
							tblWorkContent.fkLanguageBranchID = tblLanguageBranch.pkID
						WHERE
							LanguageID = @LanguageBranch
						AND
							tblWorkContent.pkID = @VersionID)
			RAISERROR('@LanguageBranch %s is not the same as Language Branch for page version %d' ,16,1, @LanguageBranch,@VersionID)
	END
	
	IF(@LanguageBranch IS NOT NULL)
		SELECT @LangBranchID = pkID FROM tblLanguageBranch WHERE LanguageID = @LanguageBranch;
	ELSE
		SELECT @LangBranchID = fkLanguageBranchID FROM tblWorkContent WHERE pkID = @VersionID;
	
	IF(@CategoryType <> 0)
		SELECT @LanguageSpecific = LanguageSpecific FROM tblPageDefinition WHERE pkID = @CategoryType;
	ELSE
		SET @LanguageSpecific = 0;

	IF @LangBranchID IS NULL AND @LanguageSpecific > 2
		RAISERROR('Language branch %s is not defined',16,1, @LanguageBranch)

	IF @LanguageSpecific < 3 AND @VersionID IS NOT NULL
	BEGIN
		IF EXISTS(SELECT pkID FROM tblContent WHERE pkID=@ContentID AND fkMasterLanguageBranchID<>@LangBranchID)
		BEGIN
			SELECT @VersionID = tblContentLanguage.Version 
				FROM tblContentLanguage 
				INNER JOIN tblContent ON tblContent.pkID=tblContentLanguage.fkContentID
				WHERE tblContent.pkID=@ContentID AND tblContentLanguage.fkLanguageBranchID=tblContent.fkMasterLanguageBranchID			
		END
	END

	IF (@VersionID IS NOT NULL)
	BEGIN
		/* Get info from tblWorkContentCategory */
		SELECT
			fkCategoryID AS CategoryID
		FROM
			tblWorkContentCategory
		WHERE
			ScopeName=@ScopeName AND
			fkWorkContentID=@VersionID
	END
	ELSE
	BEGIN
		/* Get info from tblContentcategory */
		SELECT
			fkCategoryID AS CategoryID
		FROM
			tblContentCategory
		WHERE
			ScopeName=@ScopeName AND
			fkContentID=@ContentID AND
			(fkLanguageBranchID=@LangBranchID OR @LanguageSpecific < 3)
	END
	
	RETURN 0
END
GO
PRINT N'Creating [dbo].[netBlockTypeGetUsage]...';


GO
CREATE PROCEDURE [dbo].[netBlockTypeGetUsage]
(
	@BlockTypeID		INT,
	@OnlyPublished	BIT = 0
)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@OnlyPublished = 1)
	BEGIN
		SELECT DISTINCT
			Property.fkContentID as ContentID, 
			0 AS WorkID,
			ContentLanguage.Name,
			LanguageBranch.LanguageID AS LanguageBranch
		FROM tblContentProperty as Property WITH(INDEX(IDX_tblContentProperty_ScopeName))
		INNER JOIN dbo.GetScopedBlockProperties(@BlockTypeID) as ScopedProperties ON 
			Property.ScopeName LIKE (ScopedProperties.ScopeName + '%')
		INNER JOIN tblContentLanguage as ContentLanguage ON Property.fkContentID=ContentLanguage.fkContentID
		INNER JOIN tblLanguageBranch as LanguageBranch ON LanguageBranch.pkID=ContentLanguage.fkLanguageBranchID
	END
	ELSE
	BEGIN
		SELECT DISTINCT
			WorkContent.fkContentID as ContentID, 
			WorkContent.pkID as WorkID,
			WorkContent.Name,
			LanguageBranch.LanguageID AS LanguageBranch
		FROM tblWorkContentProperty as Property WITH(INDEX(IDX_tblWorkContentProperty_ScopeName))
		INNER JOIN dbo.GetScopedBlockProperties(@BlockTypeID) as ScopedProperties ON 
			Property.ScopeName LIKE (ScopedProperties.ScopeName + '%')
		INNER JOIN tblWorkContent as WorkContent ON WorkContent.pkID = Property.fkWorkContentID
		INNER JOIN tblLanguageBranch as LanguageBranch ON LanguageBranch.pkID=WorkContent.fkLanguageBranchID
	END
END
GO
PRINT N'Creating [dbo].[netBlockTypeCheckUsage]...';


GO
CREATE PROCEDURE [dbo].[netBlockTypeCheckUsage]
(
	@BlockTypeID		INT,
	@OnlyPublished	BIT = 0
)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@OnlyPublished = 1)
	BEGIN
		SELECT TOP 1
			Property.fkContentID as ContentID, 
			0 AS WorkID
		FROM tblContentProperty as Property WITH(INDEX(IDX_tblContentProperty_ScopeName))
		INNER JOIN dbo.GetScopedBlockProperties(@BlockTypeID) as ScopedProperties ON 
			Property.ScopeName LIKE (ScopedProperties.ScopeName + '%')
	END
	ELSE
	BEGIN
		SELECT TOP 1
			WorkContent.fkContentID as ContentID, 
			WorkContent.pkID as WorkID
		FROM tblWorkContentProperty as Property WITH(INDEX(IDX_tblWorkContentProperty_ScopeName))
		INNER JOIN dbo.GetScopedBlockProperties(@BlockTypeID) as ScopedProperties ON 
			Property.ScopeName LIKE (ScopedProperties.ScopeName + '%')
		INNER JOIN
			tblWorkContent as WorkContent ON Property.fkWorkContentID=WorkContent.pkID
	END
END
GO
PRINT N'Creating [dbo].[ItemSave]...';


GO
CREATE PROCEDURE [dbo].[ItemSave]
(
	@Id			NVARCHAR(100),
	@DbSchemaId	INT,
	@Name		NVARCHAR(256) = NULL,
	@ItemData	IMAGE = NULL
)
AS
BEGIN
	IF (SUBSTRING(@Name, 1, 1) = '/')
		IF (EXISTS(SELECT pkID FROM tblItem WHERE [Name]=@Name AND pkID<>@Id))
		BEGIN
			RAISERROR('Root item with name %s already exists.', 16, 1, @Name)
			RETURN
		END
	IF (EXISTS(SELECT pkID FROM tblItem WHERE pkID=@Id))
	BEGIN
		UPDATE tblItem SET
			[Name]=@Name,
			[fkSchemaId]=@DbSchemaId,
			ItemData=@ItemData
		WHERE
			pkID=@Id

		UPDATE tblRelation SET ToName=@Name WHERE ToId=@Id

		RETURN 0

	END
	INSERT INTO tblItem 
		(pkID,
		[Name],
		[fkSchemaId],
		ItemData) 
	VALUES 
		(@Id,
		@Name,
		@DbSchemaId,
		@ItemData)
	RETURN 1
END
GO
PRINT N'Creating [dbo].[ItemLoad]...';


GO
CREATE PROCEDURE dbo.ItemLoad
(
	@Id	NVARCHAR(100)
)
AS
BEGIN
	SELECT ItemData FROM tblItem WHERE pkID=@Id
END
GO
PRINT N'Creating [dbo].[ItemList]...';


GO
CREATE PROCEDURE dbo.ItemList
AS
BEGIN
	SELECT pkID, ItemData FROM tblItem
END
GO
PRINT N'Creating [dbo].[ItemFindByName]...';


GO
/*
@Id = Id of object to search under
*/
CREATE PROCEDURE [dbo].[ItemFindByName]
(
	@Id	NVARCHAR(100) = NULL OUTPUT,
	@Name NVARCHAR(256)
)
AS
BEGIN
	DECLARE @ParentId NVARCHAR(256)
	SET @ParentId	= @Id
	SET @Id			= NULL
	IF (SUBSTRING(@Name, 1, 1) = '/')
	BEGIN
		SELECT
			@Id=pkID
		FROM tblItem
		WHERE [Name]=@Name
	END
	ELSE
	BEGIN
		SELECT 
			@Id=ToId
		FROM 
			tblRelation
		WHERE 
			[ToName]=@Name AND
			FromId=@ParentId
	END
END
GO
PRINT N'Creating [dbo].[ItemDelete]...';


GO
CREATE PROCEDURE dbo.ItemDelete
(
	@Id	NVARCHAR(256)
)
AS
BEGIN
	DELETE FROM tblRelation WHERE FromId=@Id OR ToId=@Id
	DELETE FROM tblItem WHERE pkID=@Id
END
GO
PRINT N'Creating [dbo].[editSetCommonDraftVersion]...';


GO
CREATE PROCEDURE [dbo].[editSetCommonDraftVersion]
(
	@WorkContentID INT,
	@Force BIT
)
AS
BEGIN
   SET NOCOUNT ON
	SET XACT_ABORT ON

	DECLARE  @ContentLink INT
	DECLARE  @LangID INT
	DECLARE  @CommonDraft INT
	
	-- Find the ConntentLink and Language for the Page Work ID 
	SELECT   @ContentLink = fkContentID, @LangID = fkLanguageBranchID, @CommonDraft = CommonDraft from tblWorkContent where pkID = @WorkContentID
	
	
	-- If the force flag or there is a common draft which is published we will reset the common draft
	if (@Force = 1 OR EXISTS(SELECT * FROM tblWorkContent WITH(NOLOCK) WHERE fkContentID = @ContentLink AND Status=4 AND fkLanguageBranchID = @LangID AND CommonDraft = 1))
	BEGIN 	
		-- We should remove the old common draft from other content version repect to language
		UPDATE 
			tblWorkContent
		SET
			CommonDraft = 0
		FROM  tblWorkContent WITH(INDEX(IDX_tblWorkContent_fkContentID))
		WHERE
			fkContentID = @ContentLink and fkLanguageBranchID  = @LangID  
	END
	-- If the forct flag or there is no common draft for the page wirh respect to language
	IF (@Force = 1 OR NOT EXISTS(SELECT * from tblWorkContent WITH(NOLOCK)  where fkContentID = @ContentLink AND fkLanguageBranchID = @LangID AND CommonDraft = 1))
	BEGIN
		UPDATE 
			tblWorkContent
		SET
			CommonDraft = 1
		WHERE
			pkID = @WorkContentID
	END	
		
	IF (@@ROWCOUNT = 0)
		RETURN 1

	RETURN 0
END
GO
PRINT N'Creating [dbo].[editSavePropertyCategory]...';


GO
CREATE PROCEDURE [dbo].[editSavePropertyCategory]
(
	@PageID				INT,
	@WorkPageID			INT,
	@PageDefinitionID	INT,
	@Override			BIT,
	@CategoryString		NVARCHAR(2000),
	@LanguageBranch		NCHAR(17) = NULL,
	@ScopeName			nvarchar(450) = NULL
)
AS
BEGIN

	SET NOCOUNT	ON
	SET XACT_ABORT ON
	DECLARE	@PageIDString			NVARCHAR(20)
	DECLARE	@PageDefinitionIDString	NVARCHAR(20)
	DECLARE @DynProp INT
	DECLARE @retval	INT
	SET @retval = 0

	DECLARE @LangBranchID NCHAR(17);
	IF (@WorkPageID <> 0)
		SELECT @LangBranchID = fkLanguageBranchID FROM tblWorkPage WHERE pkID = @WorkPageID
	ELSE
		SELECT @LangBranchID = pkID FROM tblLanguageBranch WHERE LanguageID = @LanguageBranch

	IF @LangBranchID IS NULL 
	BEGIN 
		if @LanguageBranch IS NOT NULL
			RAISERROR('Language branch %s is not defined',16,1, @LanguageBranch)
		else
			SET @LangBranchID = 1
	END

	DECLARE @IsLanguagePublished BIT;
	IF EXISTS(SELECT fkContentID FROM tblContentLanguage 
		WHERE fkContentID = @PageID AND fkLanguageBranchID = CAST(@LangBranchID AS INT) AND Status = 4)
		SET @IsLanguagePublished = 1
	ELSE
		SET @IsLanguagePublished = 0

	SELECT @DynProp=pkID FROM tblPageDefinition WHERE pkID=@PageDefinitionID AND fkPageTypeID IS NULL
	IF (@WorkPageID IS NOT NULL)
	BEGIN
		/* Never store dynamic properties in work table */
		IF (@DynProp IS NOT NULL)
			GOTO cleanup
				
		/* Remove all categories */
		SET @PageIDString = CONVERT(NVARCHAR(20), @WorkPageID)
		SET @PageDefinitionIDString = CONVERT(NVARCHAR(20), @PageDefinitionID)
		DELETE FROM tblWorkContentCategory WHERE fkWorkContentID=@WorkPageID AND ScopeName=@ScopeName
		/* Insert new categories */
		IF (LEN(@CategoryString) > 0)
		BEGIN
			EXEC (N'INSERT INTO tblWorkContentCategory (fkWorkContentID, fkCategoryID, CategoryType, ScopeName) SELECT ' + @PageIDString + N',pkID,' + @PageDefinitionIDString + N', ''' + @ScopeName + N''' FROM tblCategory WHERE pkID IN (' + @CategoryString +N')' )
		END
		
		/* Finally update the property table */
		IF (@PageDefinitionID <> 0)
		BEGIN
			IF EXISTS(SELECT fkWorkContentID FROM tblWorkContentProperty WHERE fkWorkContentID=@WorkPageID AND fkPropertyDefinitionID=@PageDefinitionID AND ScopeName=@ScopeName)
				UPDATE tblWorkContentProperty SET Number=@PageDefinitionID WHERE fkWorkContentID=@WorkPageID 
					AND fkPropertyDefinitionID=@PageDefinitionID
					AND ((@ScopeName IS NULL AND ScopeName IS NULL) OR (@ScopeName = ScopeName))
			ELSE
				INSERT INTO tblWorkContentProperty (fkWorkContentID, fkPropertyDefinitionID, Number, ScopeName) VALUES (@WorkPageID, @PageDefinitionID, @PageDefinitionID, @ScopeName)
		END
	END
	
	IF (@WorkPageID IS NULL OR @IsLanguagePublished = 0)
	BEGIN
		/* Insert or update property */
		/* Remove all categories */
		SET @PageIDString = CONVERT(NVARCHAR(20), @PageID)
		SET @PageDefinitionIDString = CONVERT(NVARCHAR(20), @PageDefinitionID)
		DELETE FROM tblContentCategory WHERE fkContentID=@PageID AND ScopeName=@ScopeName
		AND fkLanguageBranchID=@LangBranchID
		
		/* Insert new categories */
		IF (LEN(@CategoryString) > 0)
		BEGIN
			EXEC (N'INSERT INTO tblContentCategory (fkContentID, fkCategoryID, CategoryType, fkLanguageBranchID, ScopeName) SELECT ' + @PageIDString + N',pkID,' + @PageDefinitionIDString + N', ' + @LangBranchID + N', ''' + @ScopeName + N''' FROM tblCategory WHERE pkID IN (' + @CategoryString +N')' )
		END
		
		/* Finally update the property table */
		IF (@PageDefinitionID <> 0)
		BEGIN
			IF EXISTS(SELECT fkContentID FROM tblContentProperty WHERE fkContentID=@PageID AND fkPropertyDefinitionID=@PageDefinitionID 
						AND fkLanguageBranchID=@LangBranchID AND ScopeName=@ScopeName)
				UPDATE tblContentProperty SET Number=@PageDefinitionID WHERE fkContentID=@PageID AND fkPropertyDefinitionID=@PageDefinitionID
						AND fkLanguageBranchID=@LangBranchID
						AND ((@ScopeName IS NULL AND ScopeName IS NULL) OR (@ScopeName = ScopeName))
			ELSE
				INSERT INTO tblContentProperty (fkContentID, fkPropertyDefinitionID, Number, fkLanguageBranchID, ScopeName) VALUES (@PageID, @PageDefinitionID, @PageDefinitionID, @LangBranchID, @ScopeName)
		END
				
		/* Override dynamic property definitions below the current level */
		IF (@DynProp IS NOT NULL)
		BEGIN
			IF (@Override = 1)
				DELETE FROM tblContentProperty WHERE fkPropertyDefinitionID=@PageDefinitionID AND fkContentID IN (SELECT fkChildID FROM tblTree WHERE fkParentID=@PageID)
			SET @retval = 1
		END
	END
cleanup:		
	
	RETURN @retval
END
GO
PRINT N'Creating [dbo].[editSaveContentVersionData]...';


GO
CREATE PROCEDURE [dbo].[editSaveContentVersionData]
(
	@WorkContentID		INT,
	@UserName			NVARCHAR(255),
	@Saved				DATETIME,
	@Name				NVARCHAR(255)		= NULL,
	@ExternalURL		NVARCHAR(255)		= NULL,
	@Created			DATETIME			= NULL,
	@Changed			BIT					= 0,
	@StartPublish		DATETIME			= NULL,
	@StopPublish		DATETIME			= NULL,
	@ChildOrder			INT					= 3,
	@PeerOrder			INT					= 100,
	@ContentLinkGUID	UNIQUEIDENTIFIER	= NULL,
	@LinkURL			NVARCHAR(255)		= NULL,
	@BlobUri			NVARCHAR(255)		= NULL,
	@ThumbnailUri		NVARCHAR(255)		= NULL,
	@LinkType			INT					= 0,
	@FrameID			INT					= NULL,
	@VisibleInMenu		BIT					= NULL,
	@ArchiveContentGUID	UNIQUEIDENTIFIER	= NULL,
	@FolderID			INT					= NULL,
	@ContentAssetsID	UNIQUEIDENTIFIER	= NULL,
	@ContentOwnerID		UNIQUEIDENTIFIER	= NULL,
	@URLSegment			NVARCHAR(255)		= NULL
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	DECLARE @ChangedDate			DATETIME
	DECLARE @ContentID				INT
	DECLARE @ContentTypeID			INT
	DECLARE @ParentID				INT
	DECLARE @ExternalFolderID		INT
	DECLARE @AssetsID				UNIQUEIDENTIFIER
	DECLARE @OwnerID				UNIQUEIDENTIFIER
	DECLARE @CurrentLangBranchID	INT
	DECLARE @IsMasterLang			BIT
	
	/* Pull some useful information from the published Content */
	SELECT
		@ContentID				= fkContentID,
		@ParentID				= fkParentID,
		@ContentTypeID			= fkContentTypeID,
		@ExternalFolderID		= ExternalFolderID,
		@AssetsID				= ContentAssetsID,
		@OwnerID				= ContentOwnerID,
		@IsMasterLang			= CASE WHEN tblContent.fkMasterLanguageBranchID=tblWorkContent.fkLanguageBranchID THEN 1 ELSE 0 END,
		@CurrentLangBranchID	= fkLanguageBranchID
	FROM
		tblWorkContent
	INNER JOIN tblContent ON tblContent.pkID=tblWorkContent.fkContentID
	INNER JOIN tblContentType ON tblContentType.pkID=tblContent.fkContentTypeID
	WHERE
		tblWorkContent.pkID=@WorkContentID
	
	if (@ContentID IS NULL)
	BEGIN
		RAISERROR (N'editSaveContentVersionData: The WorkContentId dosen´t exist (WorkContentID=%d)', 16, 1, @WorkContentID)
		RETURN -1
	END			
			
		/* Special case for handling external folder id. Only set new value if */
		/* current value of ExternalFolderID is null */
		IF ((@ExternalFolderID IS NULL) AND (@FolderID IS NOT NULL))
		BEGIN
			UPDATE
				tblContent
			SET
				ExternalFolderID=@FolderID
			WHERE
				pkID=@ContentID
		END


		IF ((@AssetsID IS NULL) AND (@ContentAssetsID IS NOT NULL))
		BEGIN
			UPDATE
				tblContent
			SET
				ContentAssetsID = @ContentAssetsID
			WHERE
				pkID=@ContentID
		END

		IF ((@OwnerID IS NULL) AND (@ContentOwnerID IS NOT NULL))
		BEGIN
			UPDATE
				tblContent
			SET
				ContentOwnerID = @ContentOwnerID
			WHERE
				pkID=@ContentID
		END

		/* Set new values for work Content */
		UPDATE
			tblWorkContent
		SET
			ChangedByName		= @UserName,
			ContentLinkGUID		= @ContentLinkGUID,
			ArchiveContentGUID	= @ArchiveContentGUID,
			fkFrameID			= @FrameID,
			Name				= @Name,
			LinkURL				= @LinkURL,
			BlobUri				= @BlobUri,
			ThumbnailUri		= @ThumbnailUri,
			ExternalURL			= @ExternalURL,
			URLSegment			= @URLSegment,
			VisibleInMenu		= @VisibleInMenu,
			LinkType			= @LinkType,
			Created				= COALESCE(@Created, Created),
			Saved				= @Saved,
			StartPublish		= COALESCE(@StartPublish, StartPublish),
			StopPublish			= @StopPublish,
			ChildOrderRule		= @ChildOrder,
			PeerOrder			= COALESCE(@PeerOrder, PeerOrder),
			ChangedOnPublish	= @Changed
		WHERE
			pkID=@WorkContentID
		
		IF EXISTS(SELECT * FROM tblContentLanguage WHERE fkContentID=@ContentID AND fkLanguageBranchID=@CurrentLangBranchID AND Status <> 4)
		BEGIN

			UPDATE
				tblContentLanguage
			SET
				Name			= @Name,
				Created			= @Created,
				Saved			= @Saved,
				URLSegment		= @URLSegment,
				LinkURL			= @LinkURL,
				BlobUri			= @BlobUri,
				ThumbnailUri	= @ThumbnailUri,
				StartPublish	= COALESCE(@StartPublish, StartPublish),
				StopPublish		= @StopPublish,
				ExternalURL		= Lower(@ExternalURL),
				fkFrameID		= @FrameID,
				AutomaticLink	= CASE WHEN @LinkType = 2 OR @LinkType = 3 THEN 0 ELSE 1 END,
				FetchData		= CASE WHEN @LinkType = 4 THEN 1 ELSE 0 END
			WHERE
				fkContentID=@ContentID AND fkLanguageBranchID=@CurrentLangBranchID

			/* Set some values needed for proper display in edit tree even though we have not yet published the Content */
			IF @IsMasterLang = 1
			BEGIN
				UPDATE
					tblContent
				SET
					ArchiveContentGUID	= @ArchiveContentGUID,
					ChildOrderRule		= @ChildOrder,
					PeerOrder			= @PeerOrder,
					VisibleInMenu		= @VisibleInMenu
				WHERE
					pkID=@ContentID 
			END

		END
END
GO
PRINT N'Creating [dbo].[editDeleteProperty]...';


GO
CREATE PROCEDURE dbo.editDeleteProperty
(
	@PageID			INT,
	@WorkPageID		INT,
	@PageDefinitionID	INT,
	@Override		BIT = 0,
	@LanguageBranch		NCHAR(17) = NULL,
	@ScopeName	NVARCHAR(450) = NULL
)
AS
BEGIN
	DECLARE @LangBranchID NCHAR(17);
	SELECT @LangBranchID = pkID FROM tblLanguageBranch WHERE LanguageID = @LanguageBranch
	IF @LangBranchID IS NULL 
	BEGIN 
		if @LanguageBranch IS NOT NULL
			RAISERROR('Language branch %s is not defined',16,1, @LanguageBranch)
		else
			SET @LangBranchID = -1
	END

	DECLARE @IsLanguagePublished BIT;
	IF EXISTS(SELECT fkContentID FROM tblContentLanguage 
		WHERE fkContentID = @PageID AND fkLanguageBranchID = CAST(@LangBranchID AS INT) AND [Status] = 4)
		SET @IsLanguagePublished = 1
	ELSE
		SET @IsLanguagePublished = 0
	
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	DECLARE @retval INT
	SET @retval = 0
	
		IF (@WorkPageID IS NOT NULL)
		BEGIN
			/* This only applies to categories, but since PageDefinitionID is unique
				between all properties it is safe to blindly delete like this */
			DELETE FROM
				tblWorkContentCategory
			WHERE
				fkWorkContentID = @WorkPageID
			AND
				CategoryType = @PageDefinitionID
			AND
				(@ScopeName IS NULL OR ScopeName = @ScopeName)

			DELETE FROM
				tblWorkProperty
			WHERE
				fkWorkPageID = @WorkPageID
			AND
				fkPageDefinitionID = @PageDefinitionID
			AND 
				((@ScopeName IS NULL AND ScopeName IS NULL) OR (@ScopeName = ScopeName))
		END
		ELSE
		BEGIN

			/* Might be dynamic properties */
			DELETE FROM
				tblContentCategory
			WHERE
				fkContentID = @PageID
			AND
				CategoryType = @PageDefinitionID
			AND
				(@ScopeName IS NULL OR ScopeName = @ScopeName)
			AND
			(
				@LanguageBranch IS NULL
			OR
				@LangBranchID = fkLanguageBranchID
			)


			IF (@Override = 1)
			BEGIN
				DELETE FROM
					tblProperty
				WHERE
					fkPageDefinitionID = @PageDefinitionID
				AND
					fkPageID IN (SELECT fkChildID FROM tblTree WHERE fkParentID = @PageID)
				AND
				(
					@LanguageBranch IS NULL
				OR
					@LangBranchID = tblProperty.fkLanguageBranchID
				)
				AND 
					((@ScopeName IS NULL AND ScopeName IS NULL) OR (@ScopeName = ScopeName))
				SET @retval = 1
			END
		END
		
		/* When no version is published we save value in tblProperty as well, so the property also need to be removed from tblProperty*/
		IF (@WorkPageID IS NULL OR @IsLanguagePublished = 0)
		BEGIN
			DELETE FROM
				tblProperty
			WHERE
				fkPageID = @PageID
			AND 
				fkPageDefinitionID = @PageDefinitionID  
			AND
			(
				@LanguageBranch IS NULL
			OR
				@LangBranchID = tblProperty.fkLanguageBranchID
			)
			AND
				((@ScopeName IS NULL AND ScopeName IS NULL) OR (@ScopeName = ScopeName))
		END
			
	RETURN @retval
END
GO
PRINT N'Creating [dbo].[editCreateContentVersion]...';


GO
CREATE PROCEDURE [dbo].[editCreateContentVersion]
(
	@ContentID			INT,
	@WorkContentID		INT,
	@UserName		NVARCHAR(255),
	@MaxVersions	INT = NULL,
	@SavedDate		DATETIME = NULL,
	@LanguageBranch	NCHAR(17)
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	DECLARE @NewWorkContentID		INT
	DECLARE @DeleteWorkContentID	INT
	DECLARE @ObsoleteVersions	INT
	DECLARE @retval				INT
	DECLARE @IsMasterLang		BIT
	DECLARE @LangBranchID		INT
	
	IF @SavedDate IS NULL
		SET @SavedDate = GetDate()
	
	SELECT @LangBranchID = pkID FROM tblLanguageBranch WHERE LanguageID=@LanguageBranch
	IF @LangBranchID IS NULL
	BEGIN
		RAISERROR (N'editCreateContentVersion: LanguageBranchID is null, possibly empty table tblLanguageBranch', 16, 1, @WorkContentID)
		RETURN 0
	END

	IF (@WorkContentID IS NULL OR @WorkContentID=0 )
	BEGIN
		/* If we have a published version use it, else the latest saved version */
		IF EXISTS(SELECT * FROM tblContentLanguage WHERE Status = 4 AND fkContentID=@ContentID AND fkLanguageBranchID=@LangBranchID)
			SELECT @WorkContentID=[Version] FROM tblContentLanguage WHERE fkContentID=@ContentID AND fkLanguageBranchID=@LangBranchID
		ELSE
			SELECT TOP 1 @WorkContentID=pkID FROM tblWorkContent WHERE fkContentID=@ContentID AND fkLanguageBranchID=@LangBranchID ORDER BY Saved DESC
	END

	IF EXISTS( SELECT * FROM tblContent WHERE pkID=@ContentID AND fkMasterLanguageBranchID IS NULL )
		UPDATE tblContent SET fkMasterLanguageBranchID=@LangBranchID WHERE pkID=@ContentID
	
	SELECT @IsMasterLang = CASE WHEN @LangBranchID=fkMasterLanguageBranchID THEN 1 ELSE 0 END FROM tblContent WHERE pkID=@ContentID
		
		/* Create a new version of this content */
		INSERT INTO tblWorkContent
			(fkContentID,
			fkMasterVersionID,
			ChangedByName,
			ContentLinkGUID,
			fkFrameID,
			ArchiveContentGUID,
			Name,
			LinkURL,
			ExternalURL,
			VisibleInMenu,
			LinkType,
			Created,
			Saved,
			StartPublish,
			StopPublish,
			ChildOrderRule,
			PeerOrder,
			fkLanguageBranchID)
		SELECT 
			fkContentID,
			@WorkContentID,
			@UserName,
			ContentLinkGUID,
			fkFrameID,
			ArchiveContentGUID,
			Name,
			LinkURL,
			ExternalURL,
			VisibleInMenu,
			LinkType,
			Created,
			@SavedDate,
			StartPublish,
			StopPublish,
			ChildOrderRule,
			PeerOrder,
			@LangBranchID
		FROM 
			tblWorkContent 
		WHERE 
			pkID=@WorkContentID
	
		IF (@@ROWCOUNT = 1)
		BEGIN
			/* Remember version number */
			SET @NewWorkContentID= SCOPE_IDENTITY() 
			/* Copy all properties as well */
			INSERT INTO tblWorkContentProperty
				(fkPropertyDefinitionID,
				fkWorkContentID,
				ScopeName,
				Boolean,
				Number,
				FloatNumber,
				ContentType,
				ContentLink,
				Date,
				String,
				LongString,
                LinkGuid)          
			SELECT
				fkPropertyDefinitionID,
				@NewWorkContentID,
				ScopeName,
				Boolean,
				Number,
				FloatNumber,
				ContentType,
				ContentLink,
				Date,
				String,
				LongString,
                LinkGuid
			FROM
				tblWorkContentProperty
			INNER JOIN tblPropertyDefinition ON tblPropertyDefinition.pkID=tblWorkContentProperty.fkPropertyDefinitionID
			WHERE
				fkWorkContentID=@WorkContentID
				AND (tblPropertyDefinition.LanguageSpecific>2 OR @IsMasterLang=1)--Only lang specific on non-master 
				
			/* Finally take care of categories */
			INSERT INTO tblWorkContentCategory
				(fkWorkContentID,
				fkCategoryID,
				CategoryType,
				ScopeName)
			SELECT
				@NewWorkContentID,
				fkCategoryID,
				CategoryType,
				ScopeName
			FROM
				tblWorkContentCategory
			WHERE
				fkWorkContentID=@WorkContentID
				AND (CategoryType<>0 OR @IsMasterLang=1)--No content category on languages
		END
		ELSE
		BEGIN
			/* We did not have anything corresponding to the WorkContentID, create new work content from tblContent */
			INSERT INTO tblWorkContent
				(fkContentID,
				ChangedByName,
				ContentLinkGUID,
				fkFrameID,
				ArchiveContentGUID,
				Name,
				LinkURL,
				ExternalURL,
				VisibleInMenu,
				LinkType,
				Created,
				Saved,
				StartPublish,
				StopPublish,
				ChildOrderRule,
				PeerOrder,
				fkLanguageBranchID)
			SELECT 
				@ContentID,
				COALESCE(@UserName, tblContentLanguage.CreatorName),
				tblContentLanguage.ContentLinkGUID,
				tblContentLanguage.fkFrameID,
				tblContent.ArchiveContentGUID,
				tblContentLanguage.Name,
				tblContentLanguage.LinkURL,
				tblContentLanguage.ExternalURL,
				tblContent.VisibleInMenu,
				CASE tblContentLanguage.AutomaticLink 
					WHEN 1 THEN 
						(CASE
							WHEN tblContentLanguage.ContentLinkGUID IS NULL THEN 0	/* EPnLinkNormal */
							WHEN tblContentLanguage.FetchData=1 THEN 4				/* EPnLinkFetchdata */
							ELSE 1								/* EPnLinkShortcut */
						END)
					ELSE
						(CASE 
							WHEN tblContentLanguage.LinkURL=N'#' THEN 3				/* EPnLinkInactive */
							ELSE 2								/* EPnLinkExternal */
						END)
				END AS LinkType ,
				tblContentLanguage.Created,
				@SavedDate,
				tblContentLanguage.StartPublish,
				tblContentLanguage.StopPublish,
				tblContent.ChildOrderRule,
				tblContent.PeerOrder,
				@LangBranchID
			FROM tblContentLanguage
			INNER JOIN tblContent ON tblContent.pkID=tblContentLanguage.fkContentID
			WHERE 
				tblContentLanguage.fkContentID=@ContentID AND tblContentLanguage.fkLanguageBranchID=@LangBranchID

			IF (@@ROWCOUNT = 1)
			BEGIN
				/* Remember version number */
				SET @NewWorkContentID= SCOPE_IDENTITY() 
				/* Copy all non-dynamic properties as well */
				INSERT INTO tblWorkContentProperty
					(fkPropertyDefinitionID,
					fkWorkContentID,
					ScopeName,
					Boolean,
					Number,
					FloatNumber,
					ContentType,
					ContentLink,
					Date,
					String,
					LongString,
                    LinkGuid)
				SELECT
					P.fkPropertyDefinitionID,
					@NewWorkContentID,
					P.ScopeName,
					P.Boolean,
					P.Number,
					P.FloatNumber,
					P.ContentType,
					P.ContentLink,
					P.Date,
					P.String,
					P.LongString,
                    P.LinkGuid
				FROM
					tblContentProperty AS P
				INNER JOIN
					tblPropertyDefinition AS PD ON P.fkPropertyDefinitionID=PD.pkID
				WHERE
					P.fkContentID=@ContentID AND (PD.fkContentTypeID IS NOT NULL)
					AND P.fkLanguageBranchID = @LangBranchID
					AND (PD.LanguageSpecific>2 OR @IsMasterLang=1)--Only lang specific on non-master 
					
				/* Finally take care of categories */
				INSERT INTO tblWorkContentCategory
					(fkWorkContentID,
					fkCategoryID,
					CategoryType)
				SELECT DISTINCT
					@NewWorkContentID,
					fkCategoryID,
					CategoryType
				FROM
					tblContentCategory
				LEFT JOIN
					tblPropertyDefinition AS PD ON tblContentCategory.CategoryType = PD.pkID
				WHERE
					tblContentCategory.fkContentID=@ContentID 
					AND (PD.fkContentTypeID IS NOT NULL OR tblContentCategory.CategoryType = 0) --Not dynamic properties
					AND (PD.LanguageSpecific=1 OR @IsMasterLang=1) --No content category on languages
			END
			ELSE
			BEGIN
				RAISERROR (N'Failed to create new version for content %d', 16, 1, @ContentID)
				RETURN 0
			END
		END

	/*If there is no version set for tblContentLanguage set it to this version*/
	UPDATE tblContentLanguage SET Version = @NewWorkContentID
	WHERE fkContentID = @ContentID AND fkLanguageBranchID = @LangBranchID AND Version IS NULL
	

	/* Set NewWorkContentID as Common draft version if there is no common draft or the common draft is the published version */
	EXEC editSetCommonDraftVersion @WorkContentID = @NewWorkContentID, @Force = 0			
	
	RETURN @NewWorkContentID
END
GO
PRINT N'Creating [dbo].[admDatabaseStatistics]...';


GO
CREATE PROCEDURE dbo.admDatabaseStatistics
AS
BEGIN
	SET NOCOUNT ON
	SELECT
		(SELECT Count(*) FROM tblPage) AS PageCount
END
GO
PRINT N'Creating [dbo].[editDeletePageVersionInternal]...';


GO
CREATE PROCEDURE dbo.editDeletePageVersionInternal
(
	@WorkPageID		INT
)
AS
BEGIN
	UPDATE tblWorkPage SET fkMasterVersionID=NULL WHERE fkMasterVersionID=@WorkPageID
	DELETE FROM tblWorkProperty WHERE fkWorkPageID=@WorkPageID
	DELETE FROM tblWorkCategory WHERE fkWorkPageID=@WorkPageID
	DELETE FROM tblWorkPage WHERE pkID=@WorkPageID
	
	RETURN 0
END
GO
PRINT N'Creating [dbo].[editDeletePageInternal]...';


GO
CREATE PROCEDURE [dbo].[editDeletePageInternal]
(
    @PageID INT,
    @ForceDelete INT = NULL
)
AS
BEGIN

	SET NOCOUNT ON
	SET XACT_ABORT ON
	
-- STRUCTURE
	
	-- Make sure we dump structure and features like fetch data before we start off repairing links for pages that should not get deleted
	UPDATE 
	    tblPage 
	SET 
	    fkParentID = NULL,
	    ArchivePageGUID=NULL 
	WHERE 
	    pkID IN ( SELECT pkID FROM #pages )

	UPDATE 
	    tblContentLanguage
	SET 
	    Version = NULL 
	WHERE 
	    fkContentID IN ( SELECT pkID FROM #pages )
	    
	UPDATE 
	    tblWorkPage 
	SET 
	    fkMasterVersionID=NULL,
	    PageLinkGUID=NULL,
	    ArchivePageGUID=NULL 
	WHERE 
	    fkPageID IN ( SELECT pkID FROM #pages )

-- VERSION DATA

	-- Delete page links, archiving and fetch data pointing to us from external pages
	DELETE FROM 
	    tblWorkProperty 
	WHERE 
	    PageLink IN ( SELECT pkID FROM #pages )
	    
	UPDATE 
	    tblWorkPage 
	SET 
	    ArchivePageGUID = NULL 
	WHERE 
	    ArchivePageGUID IN ( SELECT PageGUID FROM #pages )
	    
	UPDATE 
	    tblWorkPage 
	SET 
	    PageLinkGUID = NULL, 
	    LinkType=0,
	    LinkURL=
		(
			SELECT TOP 1 
			      '~/link/' + CONVERT(NVARCHAR(32),REPLACE((select top 1 PageGUID FROM tblPage where tblPage.pkID = tblWorkPage.fkPageID),'-','')) + '.aspx'
			FROM 
			    tblPageType
			WHERE 
			    tblPageType.pkID=(SELECT fkPageTypeID FROM tblPage WHERE tblPage.pkID=tblWorkPage.fkPageID)
		)
	 WHERE 
	    PageLinkGUID IN ( SELECT PageGUID FROM #pages )
	
	-- Remove workproperties,workcategories and finally the work versions themselves
	DELETE FROM 
	    tblWorkProperty 
	WHERE 
	    fkWorkPageID IN ( SELECT pkID FROM tblWorkPage WHERE fkPageID IN ( SELECT pkID FROM #pages ) )
	    
	DELETE FROM 
	    tblWorkCategory 
	WHERE 
	    fkWorkPageID IN ( SELECT pkID FROM tblWorkPage WHERE fkPageID IN ( SELECT pkID FROM #pages ) )
	    
	DELETE FROM 
	    tblWorkPage 
	WHERE 
	    fkPageID IN ( SELECT pkID FROM #pages )

-- PUBLISHED PAGE DATA

	IF (@ForceDelete IS NOT NULL)
	BEGIN
		DELETE FROM 
		    tblProperty 
		WHERE 
		    PageLink IN (SELECT pkID FROM #pages)
	END
	ELSE
	BEGIN
		/* Default action: Only delete references from pages in wastebasket */
		DELETE FROM 
			tblProperty
		FROM 
		    tblProperty AS P
		INNER JOIN 
		    tblPage ON P.fkPageID=tblPage.pkID
		WHERE
			tblPage.Deleted=1 AND
			P.PageLink IN (SELECT pkID FROM #pages)
	END

	DELETE FROM 
	    tblPropertyDefault 
	WHERE 
	    PageLink IN ( SELECT pkID FROM #pages )
	    
	UPDATE 
	    tblPage 
	SET 
	    ArchivePageGUID = NULL 
	WHERE 
	    ArchivePageGUID IN ( SELECT PageGUID FROM #pages )

	-- Remove fetch data from any external pages pointing to us

	UPDATE 
	    tblPageLanguage 
	SET     
	    PageLinkGUID = NULL, 
	    FetchData=0,
	    LinkURL=
		(
			SELECT TOP 1 
		      '~/link/' + CONVERT(NVARCHAR(32),REPLACE((select top 1 PageGUID FROM tblPage where tblPage.pkID = tblPageLanguage.fkPageID),'-','')) + '.aspx'
			FROM 
			    tblPageType
			WHERE 
			    tblPageType.pkID=(SELECT tblPage.fkPageTypeID FROM tblPage WHERE tblPage.pkID=tblPageLanguage.fkPageID)
		)
	 WHERE 
	    PageLinkGUID IN ( SELECT PageGUID FROM #pages )

	-- Remove ALC, categories and the properties
	DELETE FROM 
	    tblCategoryPage 
	WHERE 
	    fkPageID IN ( SELECT pkID FROM #pages )
	    
	DELETE FROM 
	    tblProperty 
	WHERE 
	    fkPageID IN ( SELECT pkID FROM #pages )
	    
	DELETE FROM 
	    tblContentAccess 
	WHERE 
	    fkContentID IN ( SELECT pkID FROM #pages )

-- KEYWORDS AND INDEXING
	
	DELETE FROM 
	    tblContentSoftlink
	WHERE 
	    fkOwnerContentID IN ( SELECT pkID FROM #pages )

-- PAGETYPES
	    
	UPDATE 
	    tblPageTypeDefault 
	SET 
	    fkArchivePageID=NULL 
	WHERE fkArchivePageID IN (SELECT pkID FROM #pages)

-- PAGE/TREE

	DELETE FROM 
	    tblTree 
	WHERE 
	    fkChildID IN ( SELECT pkID FROM #pages )
	    
	DELETE FROM 
	    tblTree 
	WHERE 
	    fkParentID IN ( SELECT pkID FROM #pages )
	    
	DELETE FROM 
	    tblPageLanguage 
	WHERE 
	    fkPageID IN ( SELECT pkID FROM #pages )
	    
	DELETE FROM 
	    tblPageLanguageSetting 
	WHERE 
	    fkPageID IN ( SELECT pkID FROM #pages )
   
	DELETE FROM
	    tblPage 
	WHERE 
	    pkID IN ( SELECT pkID FROM #pages )

END
GO
PRINT N'Creating [dbo].[editDeletePageCheckInternal]...';


GO
CREATE PROCEDURE dbo.editDeletePageCheckInternal
AS
BEGIN
	SET NOCOUNT ON
    SELECT
		tblPageLanguage.fkLanguageBranchID AS OwnerLanguageID,
		NULL AS ReferencedLanguageID,
        tblPageLanguage.fkPageID AS OwnerID, 
        tblPageLanguage.Name As OwnerName,
        PageLink As ReferencedID,
        tpl.Name AS ReferencedName,
        0 AS ReferenceType
    FROM 
        tblProperty 
    INNER JOIN 
        tblPage ON tblProperty.fkPageID=tblPage.pkID
	INNER JOIN 
        tblPageLanguage ON tblPageLanguage.fkPageID=tblPage.pkID
    INNER JOIN
        tblPage AS tp ON PageLink=tp.pkID
    INNER JOIN
		tblPageLanguage AS tpl ON tpl.fkPageID=tp.pkID
    WHERE 
        (tblProperty.fkPageID NOT IN (SELECT pkID FROM #pages)) AND
        (PageLink IN (SELECT pkID FROM #pages)) AND
        tblPage.Deleted=0 AND
		tblPageLanguage.fkLanguageBranchID=tblProperty.fkLanguageBranchID AND
		tpl.fkLanguageBranchID=tp.fkMasterLanguageBranchID
    
    UNION
	
    SELECT
		tblPageLanguage.fkLanguageBranchID AS OwnerLanguageID,
		NULL AS ReferencedLanguageID,    
        tblPageLanguage.fkPageID AS OwnerID,
        tblPageLanguage.Name As OwnerName,
        tp.pkID AS ReferencedID,
        tpl.Name AS ReferencedName,
        1 AS ReferenceType
    FROM
        tblPageLanguage
	INNER JOIN
		tblPage ON tblPage.pkID=tblPageLanguage.fkPageID
    INNER JOIN
        tblPage AS tp ON tblPageLanguage.PageLinkGUID = tp.PageGUID
    INNER JOIN
		tblPageLanguage AS tpl ON tpl.fkPageID=tp.pkID
    WHERE
        (tblPageLanguage.fkPageID NOT IN (SELECT pkID FROM #pages)) AND
        (tblPageLanguage.PageLinkGUID IN (SELECT PageGUID FROM #pages)) AND
        tblPage.Deleted=0 AND
		tpl.fkLanguageBranchID=tp.fkMasterLanguageBranchID
    
    UNION
	
    SELECT
		tblContentSoftlink.OwnerLanguageID AS OwnerLanguageID,
		tblContentSoftlink.ReferencedLanguageID AS ReferencedLanguageID,
        PLinkFrom.pkID AS OwnerID,
        PLinkFromLang.Name  As OwnerName,
        PLinkTo.pkID AS ReferencedID,
        PLinkToLang.Name AS ReferencedName,
        1 AS ReferenceType
    FROM
        tblContentSoftlink
    INNER JOIN
        tblPage AS PLinkFrom ON PLinkFrom.pkID=tblContentSoftlink.fkOwnerContentID
    INNER JOIN
		tblPageLanguage AS PLinkFromLang ON PLinkFromLang.fkPageID=PLinkFrom.pkID
    INNER JOIN
        tblPage AS PLinkTo ON PLinkTo.PageGUID=tblContentSoftlink.fkReferencedContentGUID
    INNER JOIN
		tblPageLanguage AS PLinkToLang ON PLinkToLang.fkPageID=PLinkTo.pkID
    WHERE
        (PLinkFrom.pkID NOT IN (SELECT pkID FROM #pages)) AND
        (PLinkTo.pkID IN (SELECT pkID FROM #pages)) AND
        PLinkFrom.Deleted=0 AND
		PLinkFromLang.fkLanguageBranchID=PLinkFrom.fkMasterLanguageBranchID AND
		PLinkToLang.fkLanguageBranchID=PLinkTo.fkMasterLanguageBranchID
        
	UNION
	
    SELECT
       	tblPageLanguage.fkLanguageBranchID AS OwnerLanguageID,
		NULL AS ReferencedLanguageID,
		tblPage.pkID AS OwnerID,
        tblPageLanguage.Name  As OwnerName,
        tp.pkID AS ReferencedID,
        tpl.Name AS ReferencedName,
        2 AS ReferenceType
    FROM
        tblPage
    INNER JOIN 
        tblPageLanguage ON tblPageLanguage.fkPageID=tblPage.pkID
    INNER JOIN
        tblPage AS tp ON tblPage.ArchivePageGUID=tp.PageGUID
    INNER JOIN
		tblPageLanguage AS tpl ON tpl.fkPageID=tp.pkID
    WHERE
        (tblPage.pkID NOT IN (SELECT pkID FROM #pages)) AND
        (tblPage.ArchivePageGUID IN (SELECT PageGUID FROM #pages)) AND
        tblPage.Deleted=0 AND
		tpl.fkLanguageBranchID=tp.fkMasterLanguageBranchID AND
		tblPageLanguage.fkLanguageBranchID=tblPage.fkMasterLanguageBranchID

	UNION
	
    SELECT 
        tblPageLanguage.fkLanguageBranchID AS OwnerLanguageID,
		NULL AS ReferencedLanguageID,
        tblPage.pkID AS OwnerID, 
        tblPageLanguage.Name  As OwnerName,
        tblPageTypeDefault.fkArchivePageID AS ReferencedID,
        tblPageType.Name AS ReferencedName,
        3 AS ReferenceType
    FROM 
        tblPageTypeDefault
    INNER JOIN
       tblPageType ON tblPageTypeDefault.fkPageTypeID=tblPageType.pkID
    INNER JOIN
        tblPage ON tblPageTypeDefault.fkArchivePageID=tblPage.pkID
	INNER JOIN 
        tblPageLanguage ON tblPageLanguage.fkPageID=tblPage.pkID
    WHERE 
        tblPageTypeDefault.fkArchivePageID IN (SELECT pkID FROM #pages) AND
        tblPageLanguage.fkLanguageBranchID=tblPage.fkMasterLanguageBranchID

    ORDER BY
       ReferenceType
		
    RETURN 0
	
END
GO
PRINT N'Creating [dbo].[ChangeNotificationTrySetValid]...';


GO
CREATE PROCEDURE [dbo].[ChangeNotificationTrySetValid]
    @connectionId uniqueidentifier
as
begin
    begin try
        begin transaction

        declare @processorId uniqueidentifier
        declare @processorStatus nvarchar(30)
        declare @processorStatusTable table (ProcessorId uniqueidentifier, ProcessorStatus nvarchar(30), LastConsistentDbUtc datetime)
        insert into @processorStatusTable (ProcessorId, ProcessorStatus, LastConsistentDbUtc)
        exec ChangeNotificationAccessConnectionWorker @connectionId
        select @processorId = ProcessorId, @processorStatus = ProcessorStatus
        from @processorStatusTable

        declare @result bit

        if (@processorStatus = 'recovering')
        begin
            update tblChangeNotificationProcessor
            set ProcessorStatus = 'valid'
            where ProcessorId = @processorId

            set @result = 1
        end
        else
        begin
            set @result = 0
        end

        commit transaction

        select @result as StateChanged
    end try
    begin catch
    declare @msg nvarchar(4000), @sev int, @stt int
        select @msg = ERROR_MESSAGE(), @sev = ERROR_SEVERITY(), @stt = ERROR_STATE()

        rollback transaction
        raiserror(@msg, @sev, @stt)
    end catch
end
GO
PRINT N'Creating [dbo].[ChangeNotificationTrySetRecovering]...';


GO
CREATE PROCEDURE [dbo].[ChangeNotificationTrySetRecovering]
    @connectionId uniqueidentifier,
    @inactiveConnectionTimeoutSeconds int
as
begin
    begin try
        begin transaction

        declare @processorId uniqueidentifier
        declare @processorStatus nvarchar(30)
        declare @processorStatusTable table (ProcessorId uniqueidentifier, ProcessorStatus nvarchar(30), LastConsistentDbUtc datetime)
        insert into @processorStatusTable (ProcessorId, ProcessorStatus, LastConsistentDbUtc)
        exec ChangeNotificationAccessConnectionWorker @connectionId
        select @processorId = ProcessorId, @processorStatus = ProcessorStatus
        from @processorStatusTable

        declare @result bit

        if (@processorStatus = 'invalid')
        begin
            delete from tblChangeNotificationConnection
            where ProcessorId = @processorId
              and LastActivityDbUtc < DATEADD(second, -@inactiveConnectionTimeoutSeconds, GETUTCDATE())

            update tblChangeNotificationProcessor
            set ProcessorStatus = 'recovering'
            where ProcessorId = @processorId

            set @result = 1
        end
        else
        begin
            set @result = 0
        end

        commit transaction

        select @result as StateChanged
    end try
    begin catch
    declare @msg nvarchar(4000), @sev int, @stt int
        select @msg = ERROR_MESSAGE(), @sev = ERROR_SEVERITY(), @stt = ERROR_STATE()

        rollback transaction
        raiserror(@msg, @sev, @stt)
    end catch
end
GO
PRINT N'Creating [dbo].[ChangeNotificationHeartBeat]...';


GO
CREATE PROCEDURE [dbo].[ChangeNotificationHeartBeat]
    @connectionId uniqueidentifier
as
begin
    begin try
        begin transaction

        exec dbo.ChangeNotificationAccessConnectionWorker @connectionId

        commit transaction
    end try
    begin catch
        declare @msg nvarchar(4000), @sev int, @stt int
        select @msg = ERROR_MESSAGE(), @sev = ERROR_SEVERITY(), @stt = ERROR_STATE()

        rollback transaction
        raiserror(@msg, @sev, @stt)
    end catch
end
GO
PRINT N'Creating [dbo].[ChangeNotificationGetStatus]...';


GO
CREATE PROCEDURE [dbo].[ChangeNotificationGetStatus]
    @connectionId uniqueidentifier
as
begin
    begin try
        begin transaction

        declare @processorId uniqueidentifier
        declare @processorStatus nvarchar(30)
        declare @lastConsistentDbUtc datetime
        declare @processorStatusTable table (ProcessorId uniqueidentifier, ProcessorStatus nvarchar(30), LastConsistentDbUtc datetime)
        insert into @processorStatusTable (ProcessorId, ProcessorStatus, LastConsistentDbUtc)
        exec ChangeNotificationAccessConnectionWorker @connectionId
        select @processorId = ProcessorId, @processorStatus = ProcessorStatus, @lastConsistentDbUtc = LastConsistentDbUtc
        from @processorStatusTable

        declare @queuedDataType nvarchar(30)
        select @queuedDataType = ChangeNotificationDataType
        from tblChangeNotificationProcessor
        where ProcessorId = @processorId

        declare @queuedItemCount int
        if (@processorStatus = 'closed')
        begin
            set @queuedItemCount = 0
        end
        else if (@queuedDataType = 'Int')
        begin
            select @queuedItemCount = COUNT(*)
            from tblChangeNotificationQueuedInt
            where ProcessorId = @processorId and ConnectionId is null
        end
        else if (@queuedDataType = 'Guid')
        begin
            select @queuedItemCount = COUNT(*)
            from tblChangeNotificationQueuedGuid
            where ProcessorId = @processorId and ConnectionId is null
        end
        else if (@queuedDataType = 'String')
        begin
            select @queuedItemCount = COUNT(*)
            from tblChangeNotificationQueuedString
            where ProcessorId = @processorId and ConnectionId is null
        end

        select
            @processorStatus as ProcessorStatus,
            @queuedItemCount as QueuedItemCount,
            case when @processorStatus = 'valid' and @queuedItemCount = 0 then GETUTCDATE() else @lastConsistentDbUtc end as LastConsistentDbUtc

        commit transaction
    end try
    begin catch
        declare @msg nvarchar(4000), @sev int, @stt int
        select @msg = ERROR_MESSAGE(), @sev = ERROR_SEVERITY(), @stt = ERROR_STATE()

        rollback transaction
        raiserror(@msg, @sev, @stt)
    end catch
end
GO
PRINT N'Creating [dbo].[ChangeNotificationDequeueString]...';


GO
CREATE PROCEDURE [dbo].[ChangeNotificationDequeueString]
    @connectionId uniqueidentifier,
    @maxItems int
as
begin
    begin try
        begin transaction

        declare @processorId uniqueidentifier
        declare @processorStatus nvarchar(30)
        declare @processorStatusTable table (ProcessorId uniqueidentifier, ProcessorStatus nvarchar(30), LastConsistentDbUtc datetime)
        insert into @processorStatusTable (ProcessorId, ProcessorStatus, LastConsistentDbUtc)
        exec ChangeNotificationAccessConnectionWorker @connectionId, 'String'
        select @processorId = ProcessorId, @processorStatus = ProcessorStatus
        from @processorStatusTable

        if (@processorStatus = 'valid')
        begin
            if exists (select 1 from tblChangeNotificationQueuedString where ConnectionId = @connectionId)
            begin
                raiserror('A batch is already pending for the specified queue connection.', 16, 1)
            end

            declare @result table (Value nvarchar(450) collate Latin1_General_BIN2)

            insert into @result (Value)
            select top (@maxItems) Value
            from tblChangeNotificationQueuedString
			where ProcessorId = @processorId
			  and ConnectionId is null
			order by QueueOrder

            update tblChangeNotificationQueuedString
            set ConnectionId = @connectionId
            where ProcessorId = @processorId
              and Value in (select Value from @result)

            select Value from @result
        end

        commit transaction
    end try
    begin catch
        declare @msg nvarchar(4000), @sev int, @stt int
        select @msg = ERROR_MESSAGE(), @sev = ERROR_SEVERITY(), @stt = ERROR_STATE()

        rollback transaction
        raiserror(@msg, @sev, @stt)
    end catch
end
GO
PRINT N'Creating [dbo].[ChangeNotificationDequeueInt]...';


GO
CREATE PROCEDURE [dbo].[ChangeNotificationDequeueInt]
    @connectionId uniqueidentifier,
    @maxItems int
as
begin
    begin try
        begin transaction

        declare @processorId uniqueidentifier
        declare @processorStatus nvarchar(30)
        declare @processorStatusTable table (ProcessorId uniqueidentifier, ProcessorStatus nvarchar(30), LastConsistentDbUtc datetime)
        insert into @processorStatusTable (ProcessorId, ProcessorStatus, LastConsistentDbUtc)
        exec ChangeNotificationAccessConnectionWorker @connectionId, 'Int'
        select @processorId = ProcessorId, @processorStatus = ProcessorStatus
        from @processorStatusTable

        if (@processorStatus = 'valid')
        begin
            if exists (select 1 from tblChangeNotificationQueuedInt where ConnectionId = @connectionId)
            begin
                raiserror('A batch is already pending for the specified queue connection.', 16, 1)
            end

            declare @result table (Value int)

            insert into @result (Value)
            select top (@maxItems) Value
            from tblChangeNotificationQueuedInt
            where ProcessorId = @processorId
			  and ConnectionId is null
			order by QueueOrder

            update tblChangeNotificationQueuedInt
            set ConnectionId = @connectionId
            where ProcessorId = @processorId
              and Value in (select Value from @result)

            select Value from @result
        end

        commit transaction
    end try
    begin catch
        declare @msg nvarchar(4000), @sev int, @stt int
        select @msg = ERROR_MESSAGE(), @sev = ERROR_SEVERITY(), @stt = ERROR_STATE()

        rollback transaction
        raiserror(@msg, @sev, @stt)
    end catch
end
GO
PRINT N'Creating [dbo].[ChangeNotificationDequeueGuid]...';


GO
CREATE PROCEDURE [dbo].[ChangeNotificationDequeueGuid]
    @connectionId uniqueidentifier,
    @maxItems int
as
begin
    begin try
        begin transaction

        declare @processorId uniqueidentifier
        declare @processorStatus nvarchar(30)
        declare @processorStatusTable table (ProcessorId uniqueidentifier, ProcessorStatus nvarchar(30), LastConsistentDbUtc datetime)
        insert into @processorStatusTable (ProcessorId, ProcessorStatus, LastConsistentDbUtc)
        exec ChangeNotificationAccessConnectionWorker @connectionId, 'Guid'
        select @processorId = ProcessorId, @processorStatus = ProcessorStatus
        from @processorStatusTable

        if (@processorStatus = 'valid')
        begin
            if exists (select 1 from tblChangeNotificationQueuedGuid where ConnectionId = @connectionId)
            begin
                raiserror('A batch is already pending for the specified queue connection.', 16, 1)
            end

            declare @result table (Value uniqueidentifier)

            insert into @result (Value)
            select top (@maxItems) Value
            from tblChangeNotificationQueuedGuid
            where ProcessorId = @processorId
			  and ConnectionId is null
            order by QueueOrder

            update tblChangeNotificationQueuedGuid
            set ConnectionId = @connectionId
            where ProcessorId = @processorId
              and Value in (select Value from @result)

            select Value from @result
        end

        commit transaction
    end try
    begin catch
        declare @msg nvarchar(4000), @sev int, @stt int
        select @msg = ERROR_MESSAGE(), @sev = ERROR_SEVERITY(), @stt = ERROR_STATE()

        rollback transaction
        raiserror(@msg, @sev, @stt)
    end catch
end
GO
PRINT N'Creating [dbo].[ChangeNotificationCompleteBatchString]...';


GO
CREATE PROCEDURE [dbo].[ChangeNotificationCompleteBatchString]
    @connectionId uniqueidentifier,
    @success bit
as
begin
    begin try
        begin transaction

        declare @processorId uniqueidentifier
        declare @processorStatus nvarchar(30)
        declare @processorStatusTable table (ProcessorId uniqueidentifier, ProcessorStatus nvarchar(30), LastConsistentDbUtc datetime)
        insert into @processorStatusTable (ProcessorId, ProcessorStatus, LastConsistentDbUtc)
        exec ChangeNotificationAccessConnectionWorker @connectionId, 'String'
        select @processorId = ProcessorId, @processorStatus = ProcessorStatus
        from @processorStatusTable

        if (@processorStatus != 'invalid' and @processorStatus != 'closed')
        begin
            if (@success = 1)
            begin
                delete from tblChangeNotificationQueuedString
                where ConnectionId = @connectionId


                if not exists (select 1 from tblChangeNotificationQueuedString where ProcessorId = @processorId)
                begin
                    update tblChangeNotificationProcessor
                    set NextQueueOrderValue = 0, LastConsistentDbUtc = GETUTCDATE()
                    where ProcessorId = @processorId
                end
            end
            else
            begin
                declare @queueOrder int
                update tblChangeNotificationProcessor
                set @queueOrder = NextQueueOrderValue = NextQueueOrderValue + 1
                where ProcessorId = @processorId

                update tblChangeNotificationQueuedString
                set QueueOrder = @queueOrder, ConnectionId = null
                where ConnectionId = @connectionId
            end
        end

        commit transaction
    end try
    begin catch
    declare @msg nvarchar(4000), @sev int, @stt int
        select @msg = ERROR_MESSAGE(), @sev = ERROR_SEVERITY(), @stt = ERROR_STATE()

        rollback transaction
        raiserror(@msg, @sev, @stt)
    end catch
end
GO
PRINT N'Creating [dbo].[ChangeNotificationCompleteBatchInt]...';


GO
CREATE PROCEDURE [dbo].[ChangeNotificationCompleteBatchInt]
    @connectionId uniqueidentifier,
    @success bit
as
begin
    begin try
        begin transaction

        declare @processorId uniqueidentifier
        declare @processorStatus nvarchar(30)
        declare @processorStatusTable table (ProcessorId uniqueidentifier, ProcessorStatus nvarchar(30), LastConsistentDbUtc datetime)
        insert into @processorStatusTable (ProcessorId, ProcessorStatus, LastConsistentDbUtc)
        exec ChangeNotificationAccessConnectionWorker @connectionId, 'Int'
        select @processorId = ProcessorId, @processorStatus = ProcessorStatus
        from @processorStatusTable

        if (@processorStatus != 'invalid' and @processorStatus != 'closed')
        begin
            if (@success = 1)
            begin
                delete from tblChangeNotificationQueuedInt
                where ConnectionId = @connectionId

                if not exists (select 1 from tblChangeNotificationQueuedInt where ProcessorId = @processorId)
                begin
                    update tblChangeNotificationProcessor
                    set NextQueueOrderValue = 0, LastConsistentDbUtc = GETUTCDATE()
                    where ProcessorId = @processorId
                end
            end
            else
            begin
                declare @queueOrder int
                update tblChangeNotificationProcessor
                set @queueOrder = NextQueueOrderValue = NextQueueOrderValue + 1
                where ProcessorId = @processorId

                update tblChangeNotificationQueuedInt
                set QueueOrder = @queueOrder, ConnectionId = null
                where ConnectionId = @connectionId
            end
        end

        commit transaction
    end try
    begin catch
    declare @msg nvarchar(4000), @sev int, @stt int
        select @msg = ERROR_MESSAGE(), @sev = ERROR_SEVERITY(), @stt = ERROR_STATE()

        rollback transaction
        raiserror(@msg, @sev, @stt)
    end catch
end
GO
PRINT N'Creating [dbo].[ChangeNotificationCompleteBatchGuid]...';


GO
CREATE PROCEDURE [dbo].[ChangeNotificationCompleteBatchGuid]
    @connectionId uniqueidentifier,
    @success bit
as
begin
    begin try
        begin transaction

        declare @processorId uniqueidentifier
        declare @processorStatus nvarchar(30)
        declare @processorStatusTable table (ProcessorId uniqueidentifier, ProcessorStatus nvarchar(30), LastConsistentDbUtc datetime)
        insert into @processorStatusTable (ProcessorId, ProcessorStatus, LastConsistentDbUtc)
        exec ChangeNotificationAccessConnectionWorker @connectionId, 'Guid'
        select @processorId = ProcessorId, @processorStatus = ProcessorStatus
        from @processorStatusTable

        if (@processorStatus != 'invalid' and @processorStatus != 'closed')
        begin
            if (@success = 1)
            begin
                delete from tblChangeNotificationQueuedGuid
                where ConnectionId = @connectionId

                if not exists (select 1 from tblChangeNotificationQueuedGuid where ProcessorId = @processorId)
                begin
                    update tblChangeNotificationProcessor
                    set NextQueueOrderValue = 0, LastConsistentDbUtc = GETUTCDATE()
                    where ProcessorId = @processorId
                end
            end
            else
            begin
                declare @queueOrder int
                update tblChangeNotificationProcessor
                set @queueOrder = NextQueueOrderValue = NextQueueOrderValue + 1
                where ProcessorId = @processorId

                update tblChangeNotificationQueuedGuid
                set QueueOrder = @queueOrder, ConnectionId = null
                where ConnectionId = @connectionId
            end
        end

        commit transaction
    end try
    begin catch
    declare @msg nvarchar(4000), @sev int, @stt int
        select @msg = ERROR_MESSAGE(), @sev = ERROR_SEVERITY(), @stt = ERROR_STATE()

        rollback transaction
        raiserror(@msg, @sev, @stt)
    end catch
end
GO
PRINT N'Creating [dbo].[netPropertySearchCategoryMeta]...';


GO
CREATE PROCEDURE dbo.netPropertySearchCategoryMeta
(
	@PageID			INT,
	@PropertyName 	NVARCHAR(255),
	@Equals			BIT = 0,
	@NotEquals		BIT = 0,
	@CategoryList	NVARCHAR(2000) = NULL,
	@LanguageBranch		NCHAR(17) = NULL
)
AS
BEGIN
	DECLARE @LangBranchID NCHAR(17);
	
	CREATE TABLE #category (fkCategoryID int)

	IF NOT @CategoryList IS NULL
		EXEC netCategoryStringToTable @CategoryList=@CategoryList

	SELECT fkChildID
	FROM tblTree
	INNER JOIN tblContent WITH (NOLOCK) ON tblTree.fkChildID=tblContent.pkID
	WHERE tblContent.ContentType = 0 AND tblTree.fkParentID=@PageID 
	AND
    	(
		(@CategoryList IS NULL AND 	(
							SELECT Count(tblCategoryPage.fkPageID)
							FROM tblCategoryPage
							WHERE tblCategoryPage.CategoryType=0
							AND tblCategoryPage.fkPageID=tblTree.fkChildID
						)=0
		)
		OR
		(@Equals=1 AND tblTree.fkChildID IN
						(SELECT tblCategoryPage.fkPageID 
						FROM tblCategoryPage 
						INNER JOIN #category ON tblCategoryPage.fkCategoryID=#category.fkCategoryID 
						WHERE tblCategoryPage.CategoryType=0)
		)
		OR
		(@NotEquals=1 AND tblTree.fkChildID NOT IN
						(SELECT tblCategoryPage.fkPageID 
						FROM tblCategoryPage 
						INNER JOIN #category ON tblCategoryPage.fkCategoryID=#category.fkCategoryID 
						WHERE tblCategoryPage.CategoryType=0)
		)
	)

	DROP TABLE #category
END
GO
PRINT N'Creating [dbo].[netPropertySearchCategory]...';


GO
CREATE PROCEDURE dbo.netPropertySearchCategory
(
	@PageID			INT,
	@PropertyName 	NVARCHAR(255),
	@Equals			BIT = 0,
	@NotEquals		BIT = 0,
	@CategoryList	NVARCHAR(2000) = NULL,
	@LanguageBranch	NCHAR(17) = NULL
)
AS
BEGIN
	DECLARE @LangBranchID NCHAR(17);
	SELECT @LangBranchID=pkID FROM tblLanguageBranch WHERE LanguageID=@LanguageBranch
	IF @LangBranchID IS NULL 
	BEGIN 
		if @LanguageBranch IS NOT NULL
			RAISERROR('Language branch %s is not defined',16,1, @LanguageBranch)
		else
			SET @LangBranchID = -1
	END
	
	CREATE TABLE #category (fkCategoryID int)

	IF NOT @CategoryList IS NULL
		EXEC netCategoryStringToTable @CategoryList=@CategoryList

	IF @CategoryList IS NULL
		SELECT DISTINCT(tblProperty.fkPageID)
		FROM tblProperty
		INNER JOIN tblPageDefinition ON tblPageDefinition.pkID=tblProperty.fkPageDefinitionID
		INNER JOIN tblTree ON tblTree.fkChildID=tblProperty.fkPageID
		INNER JOIN tblPageLanguage ON tblPageLanguage.fkPageID=tblProperty.fkPageID
		INNER JOIN tblPageType ON tblPageDefinition.fkPageTypeID=tblPageType.pkID
		WHERE tblPageType.ContentType = 0 
		AND tblTree.fkParentID=@PageID 
		AND tblPageDefinition.Name=@PropertyName
		AND Property = 8		
		AND (@LangBranchID=-1 OR tblProperty.fkLanguageBranchID=@LangBranchID OR tblPageDefinition.LanguageSpecific<3)
		AND (
					SELECT Count(tblCategoryPage.fkPageID)
					FROM tblCategoryPage
					INNER JOIN tblPageDefinition ON tblPageDefinition.pkID = tblCategoryPage.CategoryType
					WHERE tblCategoryPage.CategoryType=tblProperty.fkPageDefinitionID
					AND tblCategoryPage.fkPageID=tblProperty.fkPageID
					AND (@LangBranchID=-1 OR tblCategoryPage.fkLanguageBranchID=@LangBranchID OR tblPageDefinition.LanguageSpecific<3)
			)=0
			

	ELSE
		IF @Equals=1
			SELECT DISTINCT(tblProperty.fkPageID)
			FROM tblProperty
			INNER JOIN tblPageDefinition ON tblPageDefinition.pkID=tblProperty.fkPageDefinitionID
			INNER JOIN tblTree ON tblTree.fkChildID=tblProperty.fkPageID
			INNER JOIN tblPageLanguage ON tblPageLanguage.fkPageID=tblProperty.fkPageID
			INNER JOIN tblPageType ON tblPageDefinition.fkPageTypeID=tblPageType.pkID
			WHERE tblPageType.ContentType = 0 
			AND tblTree.fkParentID=@PageID 
			AND tblPageDefinition.Name=@PropertyName
			AND Property = 8		
			AND (@LangBranchID=-1 OR tblProperty.fkLanguageBranchID=@LangBranchID OR tblPageDefinition.LanguageSpecific<3)
			AND EXISTS
					(SELECT *
					FROM tblCategoryPage 
					INNER JOIN #category ON tblCategoryPage.fkCategoryID=#category.fkCategoryID
					INNER JOIN tblPageDefinition ON tblPageDefinition.pkID = tblCategoryPage.CategoryType
					WHERE tblCategoryPage.fkPageID=tblProperty.fkPageID AND tblCategoryPage.CategoryType=tblProperty.fkPageDefinitionID
					AND (@LangBranchID=-1 OR tblCategoryPage.fkLanguageBranchID=@LangBranchID OR tblPageDefinition.LanguageSpecific<3))
		ELSE
			SELECT DISTINCT(tblProperty.fkPageID)
			FROM tblProperty
			INNER JOIN tblPageDefinition ON tblPageDefinition.pkID=tblProperty.fkPageDefinitionID
			INNER JOIN tblTree ON tblTree.fkChildID=tblProperty.fkPageID
			INNER JOIN tblPageLanguage ON tblPageLanguage.fkPageID=tblProperty.fkPageID
			INNER JOIN tblPageType ON tblPageDefinition.fkPageTypeID=tblPageType.pkID
			WHERE tblPageType.ContentType = 0 
			AND tblTree.fkParentID=@PageID 
			AND tblPageDefinition.Name=@PropertyName
			AND Property = 8		
			AND (@LangBranchID=-1 OR tblProperty.fkLanguageBranchID=@LangBranchID OR tblPageDefinition.LanguageSpecific<3)
			AND NOT EXISTS
					(SELECT *
					FROM tblCategoryPage 
					INNER JOIN #category ON tblCategoryPage.fkCategoryID=#category.fkCategoryID
					INNER JOIN tblPageDefinition ON tblPageDefinition.pkID = tblCategoryPage.CategoryType
					WHERE tblProperty.fkPageID=tblCategoryPage.fkPageID AND tblCategoryPage.CategoryType=tblProperty.fkPageDefinitionID
					AND (@LangBranchID=-1 OR tblCategoryPage.fkLanguageBranchID=@LangBranchID OR tblPageDefinition.LanguageSpecific<3))

	DROP TABLE #category
END
GO
PRINT N'Creating [dbo].[netContentLoadVersion]...';


GO
CREATE PROCEDURE dbo.netContentLoadVersion
(
	@ContentID	INT,
	@WorkID INT,
	@LangBranchID INT
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @CommonPropsWorkID INT
	DECLARE @IsMasterLanguage BIT
    DECLARE @ContentTypeID INT

	IF @WorkID IS NULL
	BEGIN
		IF @LangBranchID IS NULL OR NOT EXISTS(SELECT * FROM tblWorkContent WHERE fkContentID=@ContentID AND fkLanguageBranchID=@LangBranchID)
			SELECT @LangBranchID=COALESCE(fkMasterLanguageBranchID,1) FROM tblContent WHERE pkID=@ContentID

		SELECT @WorkID=[Version] FROM tblContentLanguage WHERE fkContentID=@ContentID AND fkLanguageBranchID=@LangBranchID AND Status = 4
		IF (@WorkID IS NULL OR @WorkID=0)
		BEGIN
			SELECT TOP 1 @WorkID=pkID FROM tblWorkContent WHERE fkContentID=@ContentID AND fkLanguageBranchID=@LangBranchID ORDER BY Saved DESC
		END
		
		IF (@WorkID IS NULL OR @WorkID=0)
		BEGIN
			EXEC netContentDataLoad @ContentID=@ContentID, @LanguageBranchID=@LangBranchID
			RETURN 0
		END		
	END
	
	/*Get the page type for the requested page*/
	SELECT @ContentTypeID = tblContent.fkContentTypeID FROM tblContent
		WHERE tblContent.pkID=@ContentID

	/* Get Language branch from page version*/
	SELECT @LangBranchID=fkLanguageBranchID FROM tblWorkContent WHERE pkID=@WorkID

	SELECT @IsMasterLanguage = CASE WHEN EXISTS(SELECT * FROM tblContent WHERE pkID=@ContentID AND fkMasterLanguageBranchID=@LangBranchID) THEN  1 ELSE 0 END
	IF (@IsMasterLanguage = 0)
	BEGIN
		SELECT @CommonPropsWorkID=tblContentLanguage.[Version] 
			FROM tblContentLanguage 
			INNER JOIN tblContent ON tblContent.pkID=tblContentLanguage.fkContentID
			WHERE tblContent.pkID=@ContentID AND tblContentLanguage.fkLanguageBranchID=tblContent.fkMasterLanguageBranchID
			
		/* Get data for page for non-master language*/
		SELECT
			tblContent.pkID AS PageLinkID,
			tblWorkContent.pkID AS PageLinkWorkID,
			fkParentID  AS PageParentLinkID,
			fkContentTypeID AS PageTypeID,
			NULL AS PageTypeName,
			CONVERT(INT,tblContent.VisibleInMenu) AS PageVisibleInMenu,
			tblContent.ChildOrderRule AS PageChildOrderRule,
			tblContent.PeerOrder AS PagePeerOrder,
			CONVERT(NVARCHAR(38),tblContent.ContentGUID) AS PageGUID,
			tblContent.ArchiveContentGUID AS PageArchiveLinkID,
			ExternalFolderID AS PageFolderID,
			ContentAssetsID,
			ContentOwnerID,
			CONVERT(INT,Deleted) AS PageDeleted,
			DeletedBy AS PageDeletedBy,
			DeletedDate AS PageDeletedDate,
			(SELECT ChildOrderRule FROM tblContent AS ParentPage WHERE ParentPage.pkID=tblContent.fkParentID) AS PagePeerOrderRule,
			fkMasterLanguageBranchID AS PageMasterLanguageBranchID,
			CreatorName
		FROM
			tblWorkContent
		INNER JOIN
			tblContent
		ON
			tblContent.pkID = tblWorkContent.fkContentID
		WHERE
			tblContent.pkID = @ContentID
		AND
			tblWorkContent.pkID = @WorkID	
	END
	ELSE
	BEGIN
		/* Get data for page for master language*/
		SELECT
			tblContent.pkID AS PageLinkID,
			tblWorkContent.pkID AS PageLinkWorkID,
			fkParentID  AS PageParentLinkID,
			fkContentTypeID AS PageTypeID,
			NULL AS PageTypeName,
			CONVERT(INT,tblWorkContent.VisibleInMenu) AS PageVisibleInMenu,
			tblWorkContent.ChildOrderRule AS PageChildOrderRule,
			tblWorkContent.PeerOrder AS PagePeerOrder,
			CONVERT(NVARCHAR(38),tblContent.ContentGUID) AS PageGUID,
			tblWorkContent.ArchiveContentGUID AS PageArchiveLinkID,
			ExternalFolderID AS PageFolderID,
			ContentAssetsID,
			ContentOwnerID,
			CONVERT(INT,Deleted) AS PageDeleted,
			DeletedBy AS PageDeletedBy,
			DeletedDate AS PageDeletedDate,
			(SELECT ChildOrderRule FROM tblContent AS ParentPage WHERE ParentPage.pkID=tblContent.fkParentID) AS PagePeerOrderRule,
			fkMasterLanguageBranchID AS PageMasterLanguageBranchID,
			tblContent.CreatorName
		FROM tblWorkContent
		INNER JOIN tblContent ON tblContent.pkID=tblWorkContent.fkContentID
		WHERE tblContent.pkID=@ContentID AND tblWorkContent.pkID=@WorkID
	END

	IF (@@ROWCOUNT = 0)
		RETURN 0
		
	/* Get data for page languages */
	SELECT
		W.Status as PageWorkStatus,
		W.fkContentID AS PageID,
		W.LinkType AS PageShortcutType,
		W.ExternalURL AS PageExternalURL,
		W.ContentLinkGUID AS PageShortcutLinkID,
		W.Name AS PageName,
		W.URLSegment AS PageURLSegment,
		W.LinkURL AS PageLinkURL,
		W.BlobUri,
		W.ThumbnailUri,
		W.Created AS PageCreated,
		tblContentLanguage.Changed AS PageChanged,
		W.Saved AS PageSaved,
		W.StartPublish AS PageStartPublish,
		W.StopPublish AS PageStopPublish,
		CASE WHEN tblContentLanguage.Status = 4 THEN CAST(0 AS BIT) ELSE CAST(1 AS BIT) END AS PagePendingPublish,
		tblContentLanguage.CreatorName AS PageCreatedBy,
		W.ChangedByName AS PageChangedBy,
		-- RTRIM(W.fkLanguageID) AS PageLanguageID,
		W.fkFrameID AS PageTargetFrame,
		W.ChangedOnPublish AS PageChangedOnPublish,
		CASE WHEN W.Status = 6 THEN 1 ELSE 0 END AS PageDelayedPublish,
		W.fkLanguageBranchID AS PageLanguageBranchID,
		W.DelayPublishUntil AS PageDelayPublishUntil
	FROM tblWorkContent AS W
	INNER JOIN tblContentLanguage ON tblContentLanguage.fkContentID=W.fkContentID
	WHERE tblContentLanguage.fkLanguageBranchID=W.fkLanguageBranchID
		AND W.pkID=@WorkID
	
	/* Get the property data */
	SELECT
		tblPageDefinition.Name AS PropertyName,
		tblPageDefinition.pkID as PropertyDefinitionID,
		ScopeName,
		CONVERT(INT, Boolean) AS Boolean,
		Number AS IntNumber,
		FloatNumber,
		PageType,
		PageLink AS PageLinkID,
		LinkGuid,
		Date AS DateValue,
		String,
		LongString,
		tblWorkContent.fkLanguageBranchID AS LanguageBranchID
	FROM tblWorkProperty
	INNER JOIN tblWorkContent ON tblWorkContent.pkID=tblWorkProperty.fkWorkPageID
	INNER JOIN tblPageDefinition ON tblPageDefinition.pkID=tblWorkProperty.fkPageDefinitionID
	WHERE (tblWorkProperty.fkWorkPageID=@WorkID OR (tblWorkProperty.fkWorkPageID=@CommonPropsWorkID AND tblPageDefinition.LanguageSpecific<3 AND @IsMasterLanguage=0))
		   AND NOT tblPageDefinition.fkPageTypeID IS NULL

	/*Get built in category information*/
	SELECT
		fkContentID
	AS
		PageID,
		fkCategoryID,
		CategoryType,
		NULL
	FROM
		tblWorkCategory
	INNER JOIN
		tblWorkContent
	ON
		tblWorkContent.pkID = tblWorkCategory.fkWorkPageID
	WHERE
	(
		(@IsMasterLanguage = 0 AND fkWorkPageID = @CommonPropsWorkID)
		OR
		(@IsMasterLanguage = 1 AND fkWorkPageID = @WorkID)
	)
	AND
		CategoryType = 0
	ORDER BY
		fkCategoryID

	/* Get access information */
	SELECT
		fkContentID AS PageID,
		Name,
		IsRole,
		AccessMask
	FROM
		tblContentAccess
	WHERE 
	    fkContentID=@ContentID
	ORDER BY
	    IsRole DESC,
		Name

	/* Get all languages for the page */
	SELECT fkLanguageBranchID as PageLanguageBranchID FROM tblContentLanguage
		WHERE tblContentLanguage.fkContentID=@ContentID

	RETURN 0
END
GO
PRINT N'Creating [dbo].[netContentEnsureVersions]...';


GO
CREATE PROCEDURE dbo.netContentEnsureVersions
(
	@ContentID			INT
)
AS
BEGIN

	DECLARE @LangBranchID INT
	DECLARE @LanguageBranch NCHAR(17)
	DECLARE @NewWorkContentID INT
	DECLARE @UserName NVARCHAR(255)

	CREATE TABLE #ContentLangsWithoutVersion
		(fkLanguageBranchID INT)

	/* Get a list of page languages that do not have an entry in tblWorkContent for the given page */
	INSERT INTO #ContentLangsWithoutVersion
		(fkLanguageBranchID)
	SELECT 
		tblContentLanguage.fkLanguageBranchID
	FROM 
		tblContentLanguage
	WHERE	
		fkContentID=@ContentID AND
		NOT EXISTS(
			SELECT * 
			FROM 
				tblWorkContent 
			WHERE 
				tblWorkContent.fkContentID=tblContentLanguage.fkContentID AND 
				tblWorkContent.fkLanguageBranchID=tblContentLanguage.fkLanguageBranchID)

	/* Get the first language to create a page version for */
	SELECT 
		@LangBranchID=Min(fkLanguageBranchID) 
	FROM 
		#ContentLangsWithoutVersion

	WHILE NOT @LangBranchID IS NULL
	BEGIN

		/* Get language name and user name to set for page version that we are about to create */
		SELECT 
			@LanguageBranch=LanguageID 
		FROM 
			tblLanguageBranch 
		WHERE 
			pkID=@LangBranchID
		SELECT 
			@UserName=ChangedByName 
		FROM 
			tblContentLanguage 
		WHERE 
			fkContentID=@ContentID AND 
			fkLanguageBranchID=@LangBranchID

		/* Create a new page version for the given page and language */
		EXEC @NewWorkContentID = editCreateContentVersion 
			@ContentID=@ContentID, 
			@WorkContentID=NULL, 
			@UserName=@UserName,
			@LanguageBranch=@LanguageBranch

		/* TODO - check if we should mark page version as published... */
		UPDATE 
			tblWorkContent 
		SET 
			Status = 5
		WHERE 
			pkID=@NewWorkContentID
		UPDATE 
			tblContentLanguage 
		SET 
			[Version]=@NewWorkContentID 
		WHERE 
			fkContentID=@ContentID AND 
			fkLanguageBranchID=@LangBranchID

		/* Get next language for the loop */
		SELECT 
			@LangBranchID=Min(fkLanguageBranchID) 
		FROM 
			#ContentLangsWithoutVersion 
		WHERE 
			fkLanguageBranchID > @LangBranchID
	END

	DROP TABLE #ContentLangsWithoutVersion
END
GO
PRINT N'Creating [dbo].[editDeletePageCheck]...';


GO
CREATE PROCEDURE dbo.editDeletePageCheck
(
    @PageID			INT,
	@IncludeDecendents BIT
)
AS
BEGIN
    SET NOCOUNT ON
    SET XACT_ABORT ON
    
    /* Get all pages to delete (= PageID and all its childs) */
	CREATE TABLE #pages
	(
		pkID	INT PRIMARY KEY,
		PageGUID UNIQUEIDENTIFIER
	)
	INSERT INTO #pages (pkID) 
	SELECT @PageID

	IF @IncludeDecendents = 1
	BEGIN
		INSERT INTO #pages (pkID) 
		SELECT 
			fkChildID 
		FROM 
			tblTree 
		WHERE fkParentID=@PageID
	END
	
	UPDATE #pages 
		SET PageGUID = tblPage.PageGUID
	FROM tblPage INNER JOIN #pages ON #pages.pkID=tblPage.pkID
	
	EXEC editDeletePageCheckInternal
    
    DROP TABLE #pages

END
GO
PRINT N'Creating [dbo].[editDeletePage]...';


GO
CREATE PROCEDURE dbo.editDeletePage
(
    @PageID			INT,
    @ForceDelete	INT = NULL
)
AS
BEGIN
    SET NOCOUNT ON
    SET XACT_ABORT ON
    
    DECLARE @retval INT
    DECLARE @ParentID INT
    
    /* Get all pages to delete (= PageID and all its childs) */
	CREATE TABLE #pages
	(
		pkID	INT PRIMARY KEY,
		PageGUID UNIQUEIDENTIFIER
	)
	INSERT INTO #pages (pkID) 
	SELECT 
		fkChildID 
	FROM 
		tblTree 
	WHERE fkParentID=@PageID
	UNION
	SELECT @PageID
	
	UPDATE #pages 
		SET PageGUID = tblPage.PageGUID
	FROM tblPage INNER JOIN #pages ON #pages.pkID=tblPage.pkID
	
	SELECT @ParentID=fkParentID FROM tblPage WHERE pkID=@PageID
	EXEC @retval=editDeletePageInternal @PageID=@PageID, @ForceDelete=@ForceDelete
			    
    DROP TABLE #pages

	IF NOT EXISTS(SELECT * FROM tblContent WHERE fkParentID=@ParentID)
		UPDATE tblContent SET IsLeafNode = 1 WHERE pkID=@ParentID

    
    RETURN @retval
END
GO
PRINT N'Creating [dbo].[editDeleteChildsCheck]...';


GO
CREATE PROCEDURE dbo.editDeleteChildsCheck
(
    @PageID			INT
)
AS
BEGIN
    SET NOCOUNT ON
    SET XACT_ABORT ON
        
    /* Get all pages to delete (all childs of PageID) */
	CREATE TABLE #pages
	(
		pkID	INT PRIMARY KEY,
		PageGUID UNIQUEIDENTIFIER
	)
	INSERT INTO #pages (pkID) 
	SELECT 
		fkChildID 
	FROM 
		tblTree 
	WHERE fkParentID=@PageID
	
	UPDATE #pages 
		SET PageGUID = tblPage.PageGUID
	FROM tblPage INNER JOIN #pages ON #pages.pkID=tblPage.pkID
	
	EXEC editDeletePageCheckInternal
    
    DROP TABLE #pages
        
    RETURN 0
END
GO
PRINT N'Creating [dbo].[editDeleteChilds]...';


GO
CREATE PROCEDURE dbo.editDeleteChilds
(
    @PageID			INT,
    @ForceDelete	INT = NULL
)
AS
BEGIN
    SET NOCOUNT ON
    SET XACT_ABORT ON
    DECLARE @retval INT
        
    /* Get all pages to delete (all childs of PageID) */
	CREATE TABLE #pages
	(
		pkID	INT PRIMARY KEY,
		PageGUID UNIQUEIDENTIFIER
	)
	INSERT INTO #pages (pkID) 
	SELECT 
		fkChildID 
	FROM 
		tblTree 
	WHERE fkParentID=@PageID
	
	UPDATE #pages 
		SET PageGUID = tblPage.PageGUID
	FROM tblPage INNER JOIN #pages ON #pages.pkID=tblPage.pkID
	
	EXEC @retval=editDeletePageInternal @PageID=@PageID, @ForceDelete=@ForceDelete

	UPDATE tblContent SET IsLeafNode = 1 WHERE pkID=@PageID
	    
    DROP TABLE #pages
        
    RETURN @retval
END
GO
PRINT N'Creating [dbo].[editContentVersionList]...';


GO
CREATE PROCEDURE dbo.editContentVersionList
(
	@ContentID INT
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @ParentID		INT
	DECLARE @NewWorkContentID	INT
	

	/* Make sure we correct versions for page */
	EXEC netContentEnsureVersions @ContentID=@ContentID	

	/* Get info about all page versions */
	SELECT 
		W.pkID, 
		W.Name,
		W.LinkType,
		W.LinkURL,
		W.Saved, 
		W.CommonDraft,
		W.ChangedByName AS UserNameSaved,
		W.NewStatusByName As UserNameChanged,
		PT.ContentType as ContentType,
		W.Status as  WorkStatus,
		W.RejectComment,
		W.fkMasterVersionID,
		RTRIM(tblLanguageBranch.LanguageID) AS LanguageBranch,
		CASE WHEN tblContent.fkMasterLanguageBranchID=P.fkLanguageBranchID THEN 1 ELSE 0 END AS IsMasterLanguageBranch,
		W.DelayPublishUntil
	FROM
		tblContentLanguage AS P
	INNER JOIN
		tblContent
	ON
		tblContent.pkID=P.fkContentID
	LEFT JOIN
		tblWorkContent AS W
	ON
		W.fkContentID=P.fkContentID
	LEFT JOIN
		tblContentType AS PT
	ON
		tblContent.fkContentTypeID = PT.pkID
	LEFT JOIN
		tblLanguageBranch
	ON
		tblLanguageBranch.pkID=W.fkLanguageBranchID
	WHERE
		W.fkContentID=@ContentID AND W.fkLanguageBranchID=P.fkLanguageBranchID
	ORDER BY
		W.pkID
	RETURN 0
END
GO
PRINT N'Creating [dbo].[editDeletePageVersion]...';


GO
CREATE PROCEDURE dbo.editDeletePageVersion
(
	@WorkPageID		INT
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	DECLARE @PageID				INT
	DECLARE @PublishedWorkID	INT
	DECLARE @LangBranchID		INT
	
	/* Verify that we can delete this version (i e do not allow removal of current version) */
	SELECT 
		@PageID=tblPageLanguage.fkPageID, 
		@LangBranchID=tblPageLanguage.fkLanguageBranchID,
		@PublishedWorkID=tblPageLanguage.[Version] 
	FROM 
		tblWorkPage 
	INNER JOIN 
		tblPageLanguage ON tblPageLanguage.fkPageID=tblWorkPage.fkPageID AND tblPageLanguage.fkLanguageBranchID = tblWorkPage.fkLanguageBranchID
	WHERE 
		tblWorkPage.pkID=@WorkPageID
		
	IF (@@ROWCOUNT <> 1 OR @PublishedWorkID=@WorkPageID)
		RETURN -1
	IF ( (SELECT COUNT(pkID) FROM tblWorkPage WHERE fkPageID=@PageID AND fkLanguageBranchID=@LangBranchID ) < 2 )
		RETURN -1
		
	EXEC editDeletePageVersionInternal @WorkPageID=@WorkPageID
	
	RETURN 0
END
GO
PRINT N'Creating [dbo].[netContentTrimVersions]...';


GO
CREATE PROCEDURE dbo.netContentTrimVersions
(
	@ContentID		INT,
	@MaxVersions	INT = NULL
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	DECLARE @ObsoleteVersions	INT
	DECLARE @DeleteWorkContentID	INT
	DECLARE @retval		INT
	DECLARE @CurrentLanguage 	INT
	DECLARE @FirstLanguage	BIT

	SET @FirstLanguage = 1
	
	IF (@MaxVersions IS NULL OR @MaxVersions=0)
		RETURN 0
		
		CREATE TABLE #languages (fkLanguageBranchID INT)
		INSERT INTO #languages SELECT DISTINCT(fkLanguageBranchID) FROM tblWorkContent WITH(INDEX(IDX_tblWorkContent_fkContentID)) WHERE fkContentID = @ContentID 
		SET @CurrentLanguage = (SELECT MIN(fkLanguageBranchID) FROM #languages)
		
		WHILE (NOT @CurrentLanguage = 0)
		BEGIN
			DECLARE @PublishedVersion INT
			SELECT @PublishedVersion = [Version] FROM tblContentLanguage WHERE fkContentID=@ContentID AND fkLanguageBranchID=@CurrentLanguage AND Status = 4
			SELECT @ObsoleteVersions = COUNT(pkID)+CASE WHEN @PublishedVersion IS NULL THEN 0 ELSE 1 END FROM tblWorkContent  WITH(NOLOCK) WHERE fkContentID=@ContentID AND Status = 5 AND fkLanguageBranchID=@CurrentLanguage AND pkID<>@PublishedVersion
			WHILE (@ObsoleteVersions > @MaxVersions)
			BEGIN
				SELECT TOP 1 @DeleteWorkContentID=pkID FROM tblWorkContent   WITH(NOLOCK) WHERE fkContentID=@ContentID AND Status = 5 AND fkLanguageBranchID=@CurrentLanguage AND pkID<>@PublishedVersion ORDER BY pkID ASC
				EXEC @retval=editDeletePageVersion @WorkPageID=@DeleteWorkContentID
				IF (@retval <> 0)
					BREAK
				SET @ObsoleteVersions=@ObsoleteVersions - 1
			END
			IF EXISTS(SELECT fkLanguageBranchID FROM #languages WHERE fkLanguageBranchID > @CurrentLanguage)
			    SET @CurrentLanguage = (SELECT MIN(fkLanguageBranchID) FROM #languages WHERE fkLanguageBranchID > @CurrentLanguage)
		    ELSE
		        SET @CurrentLanguage = 0
		END
		
		DROP TABLE #languages
	
	RETURN 0
END
GO
PRINT N'Creating [dbo].[editPublishContentVersion]...';


GO
CREATE PROCEDURE dbo.editPublishContentVersion
(
	@WorkContentID	INT,
	@UserName NVARCHAR(255),
	@MaxVersions INT = NULL,
	@ResetCommonDraft BIT = 1,
	@PublishedDate DATETIME = NULL
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	DECLARE @ContentID INT
	DECLARE @retval INT
	DECLARE @FirstPublish BIT
	DECLARE @ParentID INT
	DECLARE @LangBranchID INT
	DECLARE @IsMasterLang BIT
	
	/* Verify that we have a Content to publish */
	SELECT	@ContentID=fkContentID,
			@LangBranchID=fkLanguageBranchID,
			@IsMasterLang = CASE WHEN tblWorkContent.fkLanguageBranchID=tblContent.fkMasterLanguageBranchID THEN 1 ELSE 0 END
	FROM tblWorkContent WITH (ROWLOCK,XLOCK)
	INNER JOIN tblContent WITH (ROWLOCK,XLOCK) ON tblContent.pkID=tblWorkContent.fkContentID
	WHERE tblWorkContent.pkID=@WorkContentID
	
	IF (@@ROWCOUNT <> 1)
		RETURN 0

	IF @PublishedDate IS NULL
		SET @PublishedDate = GetDate()
					
	/* Move Content information from worktable to published table */
	IF @IsMasterLang=1
	BEGIN
		UPDATE 
			tblContent
		SET
			ArchiveContentGUID	= W.ArchiveContentGUID,
			VisibleInMenu	= W.VisibleInMenu,
			ChildOrderRule	= W.ChildOrderRule,
			PeerOrder		= W.PeerOrder
		FROM 
			tblWorkContent AS W
		WHERE 
			tblContent.pkID=W.fkContentID AND 
			W.pkID=@WorkContentID
	END
	
	UPDATE 
			tblContentLanguage WITH (ROWLOCK,XLOCK)
		SET
			ChangedByName	= W.ChangedByName,
			ContentLinkGUID	= W.ContentLinkGUID,
			fkFrameID		= W.fkFrameID,
			Name			= W.Name,
			URLSegment		= W.URLSegment,
			LinkURL			= W.LinkURL,
			BlobUri			= W.BlobUri,
			ThumbnailUri	= W.ThumbnailUri,
			ExternalURL		= Lower(W.ExternalURL),
			AutomaticLink	= CASE WHEN W.LinkType = 2 OR W.LinkType = 3 THEN 0 ELSE 1 END,
			FetchData		= CASE WHEN W.LinkType = 4 THEN 1 ELSE 0 END,
			Created			= W.Created,
			Changed			= CASE WHEN W.ChangedOnPublish=0 AND tblContentLanguage.Status = 4 THEN Changed ELSE @PublishedDate END,
			Saved			= @PublishedDate,
			StartPublish	= COALESCE(W.StartPublish, tblContentLanguage.StartPublish, DATEADD(s, -30, @PublishedDate)),
			StopPublish		= W.StopPublish,
			Status			= 4,
			Version			= @WorkContentID,
			DelayPublishUntil = NULL
		FROM 
			tblWorkContent AS W
		WHERE 
			tblContentLanguage.fkContentID=W.fkContentID AND
			W.fkLanguageBranchID=tblContentLanguage.fkLanguageBranchID AND
			W.pkID=@WorkContentID

	IF @@ROWCOUNT!=1
		RAISERROR (N'editPublishContentVersion: Cannot find correct version in tblContentLanguage for version %d', 16, 1, @WorkContentID)

	/*Set current published version on this language to HasBeenPublished*/
	UPDATE
		tblWorkContent
	SET
		Status = 5
	WHERE
		fkContentID = @ContentID AND
		fkLanguageBranchID = @LangBranchID AND 
		Status = 4 AND
		pkID<>@WorkContentID

	/* Remember that this version has been published, and clear the delay publish date if used */
	UPDATE
		tblWorkContent
	SET
		Status = 4,
		ChangedOnPublish = 0,
		Saved=@PublishedDate,
		NewStatusByName=@UserName,
		fkMasterVersionID = NULL,
		DelayPublishUntil = NULL
	WHERE
		pkID=@WorkContentID
		
	/* Remove all properties defined for this Content except dynamic properties */
	DELETE FROM 
		tblContentProperty
	FROM 
		tblContentProperty
	INNER JOIN
		tblPropertyDefinition ON fkPropertyDefinitionID=tblPropertyDefinition.pkID
	WHERE 
		fkContentID=@ContentID AND
		fkContentTypeID IS NOT NULL AND
		fkLanguageBranchID=@LangBranchID
		
	/* Move properties from worktable to published table */
	INSERT INTO tblContentProperty 
		(fkPropertyDefinitionID,
		fkContentID,
		fkLanguageBranchID,
		ScopeName,
		[guid],
		Boolean,
		Number,
		FloatNumber,
		ContentType,
		ContentLink,
		Date,
		String,
		LongString,
		LongStringLength,
        LinkGuid)
	SELECT
		fkPropertyDefinitionID,
		@ContentID,
		@LangBranchID,
		ScopeName,
		[guid],
		Boolean,
		Number,
		FloatNumber,
		ContentType,
		ContentLink,
		Date,
		String,
		LongString,
		/* LongString is utf-16 - Datalength gives bytes, i e div by 2 gives characters */
		/* Include length to handle delayed loading of LongString with threshold */
		COALESCE(DATALENGTH(LongString), 0) / 2,
        LinkGuid
	FROM
		tblWorkContentProperty
	WHERE
		fkWorkContentID=@WorkContentID
	
	/* Move categories to published tables */
	DELETE 	tblContentCategory
	FROM tblContentCategory
	LEFT JOIN tblPropertyDefinition ON tblPropertyDefinition.pkID=tblContentCategory.CategoryType 
	WHERE 	tblContentCategory.fkContentID=@ContentID
			AND (NOT fkContentTypeID IS NULL OR CategoryType=0)
			AND (tblPropertyDefinition.LanguageSpecific>2 OR @IsMasterLang=1)--Only lang specific on non-master
			AND tblContentCategory.fkLanguageBranchID=@LangBranchID
			
	INSERT INTO tblContentCategory
		(fkContentID,
		fkCategoryID,
		CategoryType,
		fkLanguageBranchID,
		ScopeName)
	SELECT
		@ContentID,
		fkCategoryID,
		CategoryType,
		@LangBranchID,
		ScopeName
	FROM
		tblWorkContentCategory
	WHERE
		fkWorkContentID=@WorkContentID
	
	
	EXEC netContentTrimVersions @ContentID=@ContentID, @MaxVersions=@MaxVersions

	IF @ResetCommonDraft = 1
		EXEC editSetCommonDraftVersion @WorkContentID = @WorkContentID, @Force = 1				

	RETURN 0
END
GO
PRINT N'Update complete.';


GO
SET IDENTITY_INSERT tblLanguageBranch ON
GO
INSERT INTO  tblLanguageBranch([pkID], [LanguageID], [Name], [SortIndex], [SystemIconPath], [URLSegment], [Enabled])
VALUES(1, 'en               ', NULL, 10, '~/app_themes/default/images/flags/en.gif', NULL, 1)
INSERT INTO  tblLanguageBranch([pkID], [LanguageID], [Name], [SortIndex], [SystemIconPath], [URLSegment], [Enabled])
VALUES(2, 'en-GB            ', NULL, 20, '~/app_themes/default/images/flags/en-gb.gif', NULL, 0)
INSERT INTO  tblLanguageBranch([pkID], [LanguageID], [Name], [SortIndex], [SystemIconPath], [URLSegment], [Enabled])
VALUES(3, 'en-NZ            ', NULL, 30, '~/app_themes/Default/Images/flags/en-NZ.gif', NULL, 0)
INSERT INTO  tblLanguageBranch([pkID], [LanguageID], [Name], [SortIndex], [SystemIconPath], [URLSegment], [Enabled])
VALUES(4, 'en-ZA            ', NULL, 40, '~/app_themes/default/images/flags/en-za.gif', NULL, 0)
INSERT INTO  tblLanguageBranch([pkID], [LanguageID], [Name], [SortIndex], [SystemIconPath], [URLSegment], [Enabled])
VALUES(5, 'de               ', NULL, 50, '~/app_themes/Default/Images/flags/de.gif', NULL, 0)
INSERT INTO  tblLanguageBranch([pkID], [LanguageID], [Name], [SortIndex], [SystemIconPath], [URLSegment], [Enabled])
VALUES(6, 'fr               ', NULL, 60, '~/app_themes/default/images/flags/fr.gif', NULL, 0)
INSERT INTO  tblLanguageBranch([pkID], [LanguageID], [Name], [SortIndex], [SystemIconPath], [URLSegment], [Enabled])
VALUES(7, 'es               ', NULL, 70, '~/app_themes/default/images/flags/es.gif', NULL, 0)
INSERT INTO  tblLanguageBranch([pkID], [LanguageID], [Name], [SortIndex], [SystemIconPath], [URLSegment], [Enabled])
VALUES(8, 'sv               ', NULL, 80, '~/app_themes/default/images/flags/sv.gif', NULL, 1)
INSERT INTO  tblLanguageBranch([pkID], [LanguageID], [Name], [SortIndex], [SystemIconPath], [URLSegment], [Enabled])
VALUES(9, 'no               ', NULL, 90, '~/app_themes/default/images/flags/no.gif', NULL, 0)
INSERT INTO  tblLanguageBranch([pkID], [LanguageID], [Name], [SortIndex], [SystemIconPath], [URLSegment], [Enabled])
VALUES(10, 'da               ', NULL, 100, '~/app_themes/default/images/flags/da.gif', NULL, 0)
INSERT INTO  tblLanguageBranch([pkID], [LanguageID], [Name], [SortIndex], [SystemIconPath], [URLSegment], [Enabled])
VALUES(11, 'fi               ', NULL, 110, '~/app_themes/default/images/flags/fi.gif', NULL, 0)
INSERT INTO  tblLanguageBranch([pkID], [LanguageID], [Name], [SortIndex], [SystemIconPath], [URLSegment], [Enabled])
VALUES(12, 'nl               ', NULL, 120, '~/app_themes/default/images/flags/nl.gif', NULL, 0)
INSERT INTO  tblLanguageBranch([pkID], [LanguageID], [Name], [SortIndex], [SystemIconPath], [URLSegment], [Enabled])
VALUES(13, 'nl-BE            ', NULL, 130, '~/app_themes/default/images/flags/nl-be.gif', NULL, 0)
INSERT INTO  tblLanguageBranch([pkID], [LanguageID], [Name], [SortIndex], [SystemIconPath], [URLSegment], [Enabled])
VALUES(14, 'pt-BR            ', NULL, 140, '~/app_themes/default/images/flags/pt-br.gif', NULL, 0)
INSERT INTO  tblLanguageBranch([pkID], [LanguageID], [Name], [SortIndex], [SystemIconPath], [URLSegment], [Enabled])
VALUES(15, '', NULL, 150, '', NULL, 0)
GO
SET IDENTITY_INSERT tblLanguageBranch OFF
GO

INSERT INTO tblAccessType (pkID,Name) VALUES (
1,
'Read')
GO
INSERT INTO tblAccessType (pkID,Name) VALUES (
2,
'Create')
GO
INSERT INTO tblAccessType (pkID,Name) VALUES (
4,
'Edit')
GO
INSERT INTO tblAccessType (pkID,Name) VALUES (
8,
'Delete')
GO
INSERT INTO tblAccessType (pkID,Name) VALUES (
16,
'Publish')
GO
INSERT INTO tblAccessType (pkID,Name) VALUES (
32,
'Administer')
GO

/************************************************************************/
SET IDENTITY_INSERT tblCategory ON
GO
INSERT INTO tblCategory (pkID,fkParentID,CategoryGUID,SortOrder,Available,Selectable,SuperCategory,CategoryName,CategoryDescription) VALUES (
1,
NULL,
'{885BD5B6-9F33-4615-8E85-6390072E824C}',
1,
0,
0,
0,
'Root',
'Starting point')
GO
SET IDENTITY_INSERT tblCategory OFF
GO

/************************************************************************/
SET IDENTITY_INSERT tblFrame ON
GO
INSERT INTO tblFrame (pkID,FrameName,FrameDescription,SystemFrame) VALUES (
1,
'target="_blank"',
'Open the link in a new window',
1)
GO
INSERT INTO tblFrame (pkID,FrameName,FrameDescription,SystemFrame) VALUES (
2,
'target="_top"',
'Open the link in the whole window',
1)
GO
SET IDENTITY_INSERT tblFrame OFF
GO

/************************************************************************/
SET IDENTITY_INSERT tblPropertyDefinitionGroup ON
GO
INSERT INTO tblPropertyDefinitionGroup (pkID,SystemGroup,Access,GroupVisible,GroupOrder,Name) VALUES (
0,
1,
1,
1,
10,
'Information')
GO
INSERT INTO tblPropertyDefinitionGroup (pkID,SystemGroup,Access,GroupVisible,GroupOrder,Name) VALUES (
1,
1,
4,
0,
30,
'Advanced')
GO
INSERT INTO tblPropertyDefinitionGroup (pkID,SystemGroup,Access,GroupVisible,GroupOrder,Name) VALUES (
2,
1,
1,
0,
50,
'Categories')
GO
INSERT INTO tblPropertyDefinitionGroup (pkID,SystemGroup,Access,GroupVisible,GroupOrder,Name) VALUES (
3,
1,
1,
0,
40,
'Shortcut')
GO
INSERT INTO tblPropertyDefinitionGroup (pkID,SystemGroup,Access,GroupVisible,GroupOrder,Name) VALUES (
4,
1,
1,
0,
20,
'Scheduling')
GO
INSERT INTO tblPropertyDefinitionGroup (pkID,SystemGroup,Access,GroupVisible,GroupOrder,Name) VALUES (
5,
1,
1,
0,
60,
'DynamicBlocks')
GO
SET IDENTITY_INSERT tblPropertyDefinitionGroup OFF
GO

/************************************************************************/
INSERT INTO tblPropertyDefinitionType (pkID,Property,Name,TypeName,AssemblyName) VALUES (
0,
0,
'Boolean',
NULL,
NULL)
GO
INSERT INTO tblPropertyDefinitionType (pkID,Property,Name,TypeName,AssemblyName) VALUES (
1,
1,
'Number',
NULL,
NULL)
GO
INSERT INTO tblPropertyDefinitionType (pkID,Property,Name,TypeName,AssemblyName) VALUES (
2,
2,
'FloatNumber',
NULL,
NULL)
GO
INSERT INTO tblPropertyDefinitionType (pkID,Property,Name,TypeName,AssemblyName) VALUES (
3,
3,
'PageType',
NULL,
NULL)
GO
INSERT INTO tblPropertyDefinitionType (pkID,Property,Name,TypeName,AssemblyName) VALUES (
4,
4,
'PageReference',
NULL,
NULL)
GO
INSERT INTO tblPropertyDefinitionType (pkID,Property,Name,TypeName,AssemblyName) VALUES (
5,
5,
'Date',
NULL,
NULL)
GO
INSERT INTO tblPropertyDefinitionType (pkID,Property,Name,TypeName,AssemblyName) VALUES (
6,
6,
'String',
NULL,
NULL)
GO
INSERT INTO tblPropertyDefinitionType (pkID,Property,Name,TypeName,AssemblyName) VALUES (
7,
7,
'LongString',
NULL,
NULL)
GO
INSERT INTO tblPropertyDefinitionType (pkID,Property,Name,TypeName,AssemblyName) VALUES (
8,
8,
'Category',
NULL,
NULL)
GO
INSERT INTO tblPropertyDefinitionType (pkID,Property,Name,TypeName,AssemblyName) VALUES (
11,
11,
'ContentReference',
NULL,
NULL)
GO

/************************************************************************/
SET IDENTITY_INSERT tblContentType ON
GO
INSERT INTO tblContentType (pkID,ContentTypeGUID,Created,Name,Description,IdString,Available,SortOrder,MetaDataInherit,MetaDataDefault,WorkflowEditFields) VALUES (
1,
'{3FA7D9E7-877B-11D3-827C-00A024CACFCB}',
'19990101 00:00',
'SysRoot',
'Used as root/welcome page',
'?id=',
0,
10000,
0,
0,
0)
GO
INSERT INTO tblContentType (pkID,ContentTypeGUID,Created,Name,Description,IdString,Available,SortOrder,MetaDataInherit,MetaDataDefault,WorkflowEditFields) VALUES (
2,
'{4EEA90CD-4210-4115-A399-6D6915554E10}',
'19990101 00:00',
'SysRecycleBin',
'Used as recycle bin for the website',
'?id=',
0,
10010,
0,
0,
0)
GO
INSERT INTO tblContentType (pkID,ContentTypeGUID,Created,ModelType,Name,Description,IdString,Available,SortOrder,MetaDataInherit,MetaDataDefault,WorkflowEditFields,ContentType) VALUES (
3,
'{52F8D1E9-6D87-4DB6-A465-41890289FB78}',
'19990101 00:00',
'EPiServer.Core.ContentFolder,EPiServer',
'SysContentFolder',
'Used as content folder',
'?id=',
0,
10020,
0,
0,
0,
2)
GO
INSERT INTO tblContentType (pkID,ContentTypeGUID,Created,ModelType,Name,Description,IdString,Available,SortOrder,MetaDataInherit,MetaDataDefault,WorkflowEditFields,ContentType) VALUES (
4,
'{E9AB78A3-1BBF-48ef-A8D4-1C1F98E80D91}',
'19990101 00:00',
'EPiServer.Core.ContentAssetFolder,EPiServer',
'SysContentAssetFolder',
'Used as a folder for content assets',
'?id=',
0,
10030,
0,
0,
0,
2)
GO
SET IDENTITY_INSERT tblContentType OFF
GO

/************************************************************************
Dependent data
************************************************************************/
SET IDENTITY_INSERT tblContent ON
GO
--SysRoot
INSERT INTO tblContent (pkID,fkContentTypeID,fkParentID,ArchiveContentGUID,CreatorName,ContentGUID,VisibleInMenu,Deleted,ChildOrderRule,PeerOrder,ExternalFolderID, fkMasterLanguageBranchID,ContentPath, IsLeafNode) VALUES (
1,--pkID
1,--fkContentTypeID
NULL,--fkParentID
NULL,--ArchiveContentGUID
'',--CreatorName
'{43F936C9-9B23-4EA3-97B2-61C538AD07C9}',--ContentGUID
1,--VisibleInMenu
0,--Deleted
4,--ChildOrderRule
100,--PeerOrder
1,--ExternalFolderID
1,--fkMasterLanguageBranchID
'.',--ContentPath
0)--IsLeafNode
GO

--SysWastebasket
INSERT INTO tblContent (pkID,fkContentTypeID,fkParentID,ArchiveContentGUID,CreatorName,ContentGUID,VisibleInMenu,Deleted,ChildOrderRule,PeerOrder,ExternalFolderID,fkMasterLanguageBranchID,ContentPath) VALUES (
2,--pkID
2,--fkContentTypeID
1,--fkParentID
NULL,--ArchiveContentGUID
'',--CreatorName
'{2F40BA47-F4FC-47AE-A244-0B909D4CF988}',--ContentGUID
1,--VisibleInMenu
0,--Deleted
1,--ChildOrderRule
10,--PeerOrder
2,--ExternalFolderID
1,--fkMasterLanguageBranchID
'.1.')--ContentPath
GO

--SysGlobalAssets
INSERT INTO tblContent (pkID,fkContentTypeID,fkParentID,ArchiveContentGUID,CreatorName,ContentGUID,VisibleInMenu,Deleted,ChildOrderRule,PeerOrder,ExternalFolderID,fkMasterLanguageBranchID,ContentPath,ContentType) VALUES (
3,--pkID
3,--fkContentTypeID
1,--fkParentID
NULL,--ArchiveContentGUID
'',--CreatorName
'{E56F85D0-E833-4E02-976A-2D11FE4D598C}',--ContentGUID
1,--VisibleInMenu
0,--Deleted
3,--ChildOrderRule
100,--PeerOrder
0,--ExternalFolderID
15,--fkMasterLanguageBranchID
'.1.',--ContentPath
2)--ContentType
GO

--SysContentAssets
INSERT INTO tblContent (pkID,fkContentTypeID,fkParentID,ArchiveContentGUID,CreatorName,ContentGUID,VisibleInMenu,Deleted,ChildOrderRule,PeerOrder,ExternalFolderID,fkMasterLanguageBranchID,ContentPath,ContentType) VALUES (
4,--pkID
3,--fkContentTypeID
1,--fkParentID
NULL,--ArchiveContentGUID
'',--CreatorName
'{99D57529-61F2-47C0-80C0-F91ECA6AF1AC}',--ContentGUID
1,--VisibleInMenu
0,--Deleted
3,--ChildOrderRule
100,--PeerOrder
0,--ExternalFolderID
15,--fkMasterLanguageBranchID
'.1.',--ContentPath
2)--ContentType
GO
SET IDENTITY_INSERT tblContent OFF
GO

--Root
DECLARE @fkPageId1 INT
INSERT INTO tblWorkContent (fkContentID ,fkMasterVersionID, ContentLinkGUID, fkFrameID, ArchiveContentGUID, ChangedByName, NewStatusByName, Name, URLSegment,LinkURL ,ExternalURL ,VisibleInMenu ,LinkType ,Created ,Saved ,StartPublish ,StopPublish ,ChildOrderRule ,PeerOrder ,ChangedOnPublish ,RejectComment ,fkLanguageBranchID, Status) VALUES (
1, --fkContentID
null, --,fkMasterVersionID
null, --,ContentLinkGUID
null,--,fkFrameID
null,--,ArchiveContentGUID
'', --,ChangedByName
null, --,NewStatusByName
'Root',--Name
null, --,URLSegment
'~/link/43F936C99B234EA397B261C538AD07C9.aspx',--LinkURL
null, --,ExternalURL
1, --,VisibleInMenu
0, --,LinkType
'19990101 00:00', --,Created
'19990101 00:00', --,Saved
'19990101 00:00', --,StartPublish
null, --,StopPublish
4, --,ChildOrderRule
100, --,PeerOrder
0, --,ChangedOnPublish
null,--,RejectComment
1,--,fkLanguageBranchID
4 --status
)
SET @fkPageId1=@@IDENTITY

--RecycleBin
DECLARE @fkPageId2 INT
INSERT INTO tblWorkContent (fkContentID ,fkMasterVersionID, ContentLinkGUID, fkFrameID, ArchiveContentGUID, ChangedByName, NewStatusByName, Name, URLSegment,LinkURL ,ExternalURL ,VisibleInMenu ,LinkType ,Created ,Saved ,StartPublish ,StopPublish ,ChildOrderRule ,PeerOrder ,ChangedOnPublish ,RejectComment ,fkLanguageBranchID, Status) VALUES (
2, --fkContentID
null, --,fkMasterVersionID
null, --,ContentLinkGUID
null,--,fkFrameID
null,--,ArchiveContentGUID
'', --,ChangedByName
null, --,NewStatusByName
'Recycle Bin',--Name
null, --,URLSegment
'~/link/2F40BA47F4FC47AEA2440B909D4CF988.aspx',--LinkURL
null, --,ExternalURL
1, --,VisibleInMenu
0, --,LinkType
'19990101 00:00', --,Created
'19990101 00:00', --,Saved
'19990101 00:00', --,StartPublish
null, --,StopPublish
1, --,ChildOrderRule
10, --,PeerOrder
0, --,ChangedOnPublish
null,--,RejectComment
1,--,fkLanguageBranchID
4 --Status
)
SET @fkPageId2=@@IDENTITY


DECLARE @fkPageId3 INT
INSERT INTO tblWorkContent (fkContentID ,fkMasterVersionID, ContentLinkGUID, fkFrameID, ArchiveContentGUID, ChangedByName, NewStatusByName, Name, URLSegment,LinkURL ,ExternalURL ,VisibleInMenu ,LinkType ,Created ,Saved ,StartPublish ,StopPublish ,ChildOrderRule ,PeerOrder ,ChangedOnPublish ,RejectComment ,fkLanguageBranchID, Status) VALUES (
3, --fkContentID
null, --,fkMasterVersionID
null, --,ContentLinkGUID
null,--,fkFrameID
null,--,ArchiveContentGUID
'', --,ChangedByName
null, --,NewStatusByName
'SysGlobalAssets',--Name
'SysGlobalAssets', --,URLSegment
null,--LinkURL
null, --,ExternalURL
1, --,VisibleInMenu
0, --,LinkType
'19990101 00:00', --,Created
'19990101 00:00', --,Saved
'19990101 00:00', --,StartPublish
null, --,StopPublish
3, --,ChildOrderRule
100, --,PeerOrder
0, --,ChangedOnPublish
null,--,RejectComment
15,--,fkLanguageBranchID
4 -- Status
)
SET @fkPageId3=@@IDENTITY

DECLARE @fkPageId4 INT
INSERT INTO tblWorkContent (fkContentID ,fkMasterVersionID, ContentLinkGUID, fkFrameID, ArchiveContentGUID, ChangedByName, NewStatusByName, Name, URLSegment,LinkURL ,ExternalURL ,VisibleInMenu ,LinkType ,Created ,Saved ,StartPublish ,StopPublish ,ChildOrderRule ,PeerOrder ,ChangedOnPublish ,RejectComment ,fkLanguageBranchID, Status) VALUES (
4, --fkContentID
null, --,fkMasterVersionID
null, --,ContentLinkGUID
null,--,fkFrameID
null,--,ArchiveContentGUID
'', --,ChangedByName
null, --,NewStatusByName
'SysContentAssets',--Name
'SysContentAssets', --,URLSegment
null,--LinkURL
null, --,ExternalURL
1, --,VisibleInMenu
0, --,LinkType
'19990101 00:00', --,Created
'19990101 00:00', --,Saved
'19990101 00:00', --,StartPublish
null, --,StopPublish
3, --,ChildOrderRule
100, --,PeerOrder
0, --,ChangedOnPublish
null,--,RejectComment
15,--,fkLanguageBranchID
4 --Status
)
SET @fkPageId4=@@IDENTITY

INSERT INTO tblContentLanguage (fkContentID,fkLanguageBranchID,ContentLinkGUID,fkFrameID,CreatorName,ChangedByName,ContentGUID,Name,LinkURL,ExternalURL,AutomaticLink,FetchData,Created,Changed,Saved,StartPublish,StopPublish,[Version], Status) VALUES (
1,--fkContentID
1,--fkLanguageBranchID
NULL,--ContentLinkGUID
NULL,--fkFrameID
'',--CreatorName
'',--ChangedByName
'{43F936C9-9B23-4EA3-97B2-61C538AD07C9}',--ContentGUID
'Root',--Name
'~/link/43F936C99B234EA397B261C538AD07C9.aspx',--LinkURL
NULL,--ExternalURL
1,--AutomaticLink
0,--FetchData
'19990101 00:00',--Created
'19990101 00:00',--Changed
'19990101 00:00',--Saved
'19990101 00:00',--StartPublish
NULL,--StopPublish
@fkPageId1,--Version
4 --Status
)

INSERT INTO tblContentLanguage (fkContentID,fkLanguageBranchID,ContentLinkGUID,fkFrameID,CreatorName,ChangedByName,ContentGUID,Name,URLSegment,LinkURL,ExternalURL,AutomaticLink,FetchData,Created,Changed,Saved,StartPublish,StopPublish,[Version], Status) VALUES (
2,--fkContentID
1,--fkLanguageBranchID
NULL,--ContentLinkGUID
NULL,--fkFrameID
'',--CreatorName
'',--ChangedByName
'{2F40BA47-F4FC-47AE-A244-0B909D4CF988}',--ContentGUID
'Recycle Bin',--Name
'Recycle-Bin',--URLSegment
'~/link/2F40BA47F4FC47AEA2440B909D4CF988.aspx',--LinkURL
NULL,--ExternalURL
1,--AutomaticLink
0,--FetchData
'19990101 00:00',--Created
'19990101 00:00',--Changed
'19990101 00:00',--Saved
'19990101 00:00',--StartPublish
NULL,--StopPublish
@fkPageId2,--Version
4 --Status
)

INSERT INTO tblContentLanguage (fkContentID,fkLanguageBranchID,ContentLinkGUID,fkFrameID,CreatorName,ChangedByName,ContentGUID,Name,URLSegment,LinkURL,ExternalURL,AutomaticLink,FetchData,Created,Changed,Saved,StartPublish,StopPublish,[Version], Status) VALUES (
3,--fkContentID
15,--fkLanguageBranchID
NULL,--ContentLinkGUID
NULL,--fkFrameID
'',--CreatorName
'',--ChangedByName
'{E56F85D0-E833-4E02-976A-2D11FE4D598C}',--ContentGUID
'SysGlobalAssets',--Name
'SysGlobalAssets',--URLSegment
null,--LinkURL
NULL,--ExternalURL
1,--AutomaticLink
0,--FetchData
'19990101 00:00',--Created
'19990101 00:00',--Changed
'19990101 00:00',--Saved
'19990101 00:00',--StartPublish
NULL,--StopPublish
@fkPageId3,--Version
4 --Status
)

INSERT INTO tblContentLanguage (fkContentID,fkLanguageBranchID,ContentLinkGUID,fkFrameID,CreatorName,ChangedByName,ContentGUID,Name,URLSegment,LinkURL,ExternalURL,AutomaticLink,FetchData,Created,Changed,Saved,StartPublish,StopPublish,[Version], Status) VALUES (
4,--fkContentID
15,--fkLanguageBranchID
NULL,--ContentLinkGUID
NULL,--fkFrameID
'',--CreatorName
'',--ChangedByName
'{99D57529-61F2-47C0-80C0-F91ECA6AF1AC}',--ContentGUID
'SysContentAssets',--Name
'SysContentAssets',--URLSegment
null,--LinkURL
NULL,--ExternalURL
1,--AutomaticLink
0,--FetchData
'19990101 00:00',--Created
'19990101 00:00',--Changed
'19990101 00:00',--Saved
'19990101 00:00',--StartPublish
NULL,--StopPublish
@fkPageId4,--Version
4 --Status
)
GO

/************************************************************************/
INSERT INTO tblUserPermission (Name,IsRole,Permission) VALUES ('Administrators',1,2)    /* DetailedErrorMessage */
GO

/************************************************************************/
INSERT INTO tblContentAccess (fkContentID,Name,IsRole,AccessMask) VALUES (1,'Everyone',1,1)
INSERT INTO tblContentAccess (fkContentID,Name,IsRole,AccessMask) VALUES (2,'Everyone',1,1)
INSERT INTO tblContentAccess (fkContentID,Name,IsRole,AccessMask) VALUES (1,'Administrators',1,63)
INSERT INTO tblContentAccess (fkContentID,Name,IsRole,AccessMask) VALUES (2,'Administrators',1,63)
GO

/************************************************************************/
INSERT INTO tblTree (fkParentID,fkChildID,NestingLevel) VALUES (1,2,1)
GO

INSERT INTO tblTree (fkParentID,fkChildID,NestingLevel) VALUES (1,3,1)
GO

INSERT INTO tblTree (fkParentID,fkChildID,NestingLevel) VALUES (1,4,1)
GO
