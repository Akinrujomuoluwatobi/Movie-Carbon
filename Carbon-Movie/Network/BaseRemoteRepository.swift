//
//  BaseRemoteRepository.swift
//

class DefaultBaseRemoteRepository {

    let requestFactory: RequestFactory

    let httpPerformer: HTTPRequestPerformer

    let baseURLHolder: BaseURLHolder

    init(requestFactory: RequestFactory, httpPerformer: HTTPRequestPerformer, baseURLHolder: BaseURLHolder) {
        self.baseURLHolder = baseURLHolder
        self.httpPerformer = httpPerformer
        self.requestFactory = requestFactory
    }
}
